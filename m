Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CE32EA481
	for <linux-block@vger.kernel.org>; Fri,  5 Dec 2025 07:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764918440; cv=none; b=T/dTPb5bDL4L6Hwk5lhDaCvwviP6BTkdHkRCyW7vV/Youqw8QdnIQwY4/BZS57BQS2LkKL9L229YQQ/eVWlAS36j5HkvvucyXvpYVF2g8i4UUJ9hGJGncYh6imxaekEB1ihVi4SddtNAe8W8mw3VjbJSQyVMapaEVoHS32++hJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764918440; c=relaxed/simple;
	bh=GhJfP9l9lj1qjUG+JI29fes7oqCn16v13hAgHQfV+7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZyaZUfTcuhGJyy3W6GMw3QVwysoKEB1XIcXP6WZknvBCnkEsJ8qFkGDFjEqIfWQp71vRs7HFTAo25qBNeiMRKPsRlfhnCeTcRgRbXiM+qf8b3WpTq6AJ9JHoWCDtBHVNW6T9MHAsDheFRluBMXz1xgXyWPtjfX0j9Vc4v2s8lb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kNzNapB+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=k2dfgsum; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=E9F6Nyn7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NvO9+8Nm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kNzNapB+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="k2dfgsum";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="E9F6Nyn7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NvO9+8Nm"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 001A35BD1C;
	Fri,  5 Dec 2025 07:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764918435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WO8EQkDW2LhZqqGmSLjd5kat0wnUxySmCxEH9ttL3qc=;
	b=kNzNapB+kaCpW50ZiDAA9Ym5FT6uxJW3ZRs4jrlmo/aM1fADBcYOlNr6NmAynFuJ9Daxf5
	1axcgeFV39Rwdq0yfn0NMoktZMjXv9bTClOf9U3ckqEhzGSoPvICHTF7xNHJ3381sCjZLp
	YUkt9TFZScrHtbDn91hqrBO9xiMBuXk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764918435;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WO8EQkDW2LhZqqGmSLjd5kat0wnUxySmCxEH9ttL3qc=;
	b=k2dfgsumakU63bptU+oPUUTy7M9gbGtZ3Hpz/IJQgNaz3DBXx9vcdpkePlyRF6BGiqmjFY
	e10LaY+gO7QPisAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=E9F6Nyn7;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NvO9+8Nm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764918434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WO8EQkDW2LhZqqGmSLjd5kat0wnUxySmCxEH9ttL3qc=;
	b=E9F6Nyn7jidAt+05kn8ZEvvhvF/pXB+gB+F6fhJ9PZTfGL0qfijH9WcUjdSc/FgbReRoL5
	nqNHas9qHx4UCXZaU4E6jey6pQaIRrblkCSI2QPF+HPXhIPP16aX8YU4IQ6BBe0RU/HFI7
	oJr+E8jxgzVM6cEMMdaID6GUtFw3w/M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764918434;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WO8EQkDW2LhZqqGmSLjd5kat0wnUxySmCxEH9ttL3qc=;
	b=NvO9+8NmDKUxwJ14LI2fGkDWLGzywJKKFH4obnCqUhuBw4jZ6CX+/bjqapvqNERgMsot83
	GiBH52ULjSso9VDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C30183EA63;
	Fri,  5 Dec 2025 07:07:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jATCLaGEMmmibgAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 05 Dec 2025 07:07:13 +0000
Message-ID: <89f8fe1d-bd1f-48d7-b056-333cb176260b@suse.de>
Date: Fri, 5 Dec 2025 08:07:13 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v2] scsi/004: Remove reliance on deprecated
 /proc/scsi/scsi_debug
To: Li Zhijian <lizhijian@fujitsu.com>, linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com, Bart Van Assche <bvanassche@acm.org>
References: <20251205031053.624317-1-lizhijian@fujitsu.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251205031053.624317-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: 001A35BD1C
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fujitsu.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim,suse.de:email];
	URIBL_BLOCKED(0.00)[acm.org:email,fujitsu.com:email,suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

On 12/5/25 04:10, Li Zhijian wrote:
> The Kconfig option `SCSI_PROC_FS`, which provides the
> `/proc/scsi/scsi_debug` interface, has been deprecated for a long time.
> 
> Instead of adding SCSI_PROC_FS as a requirement, refactor out the script
> to remove the scsi host to ensure all pending I/O has finished.
> 
> Prevent the following error report:
> scsi/004 (ensure repeated TASK SET FULL results in EIO on timing out command) [failed]
>      runtime  1.743s  ...  1.935s
>      --- tests/scsi/004.out      2025-04-04 04:36:43.171999880 +0800
>      +++ /root/blktests/results/nodev/scsi/004.out.bad   2025-11-13 12:46:33.807994845 +0800
>      @@ -1,3 +1,4 @@
>       Running scsi/004
>       Input/output error
>      +grep: /proc/scsi/scsi_debug/0: No such file or directory
>       Test complete
> 
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> V2: The new idea comes from Bart. Thank Bart and Shinichiro for valuable suggestions.
> ---
>   tests/scsi/004 | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/scsi/004 b/tests/scsi/004
> index 7d0af54..72c9663 100755
> --- a/tests/scsi/004
> +++ b/tests/scsi/004
> @@ -39,9 +39,9 @@ test() {
>   	# stop injection
>   	echo 0 > /sys/bus/pseudo/drivers/scsi_debug/opts
>   	# dd closing SCSI disk causes implicit TUR also being delayed once
> -	while grep -q -F "in_use_bm BUSY:" "/proc/scsi/scsi_debug/${SCSI_DEBUG_HOSTS[0]}"; do
> -		sleep 1
> -	done
> +	# Remove the SCSI host to ensure all the pending I/O has finished.
> +	host_cnt=$(cat /sys/bus/pseudo/drivers/scsi_debug/add_host)
> +	echo -"$host_cnt" > /sys/bus/pseudo/drivers/scsi_debug/add_host
>   	echo 1 > /sys/bus/pseudo/drivers/scsi_debug/ndelay
>   	_exit_scsi_debug
>   
Hmm. That will remove all scsi_debug hosts until that index; so let's
hope we're the only user of it.
But can't be helped; scsi_debug doesn't allow to selectively remove
hosts. One could do a patch for it, but not sure it's worth it.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
