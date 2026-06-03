Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2202F39C7
	for <linux-block@vger.kernel.org>; Wed,  3 Jun 2026 01:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780448859; cv=none; b=GU+rj3+RXedLaz3z6JcxjvR1RBsINEY7WgtKvwKaf6dElsguAOTrm2CMIxiDdp2Q1Y96uArAqIehfc0achD0EeXzf3Y0usEEs/TE4wXIROYGXjjEQhTAWlCSbimlK924bkvEQp+QX/Bc9G6nF55OQ7pGBJmnfCux79FXBtzVpek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780448859; c=relaxed/simple;
	bh=5gAcrqreUm3XYGK1upIvmFX53Vcsl6kTXTS1yjhSgHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NMrZQwuwOreylTKiJ99T0eTzR0anoRSVRVfnBqhV8ejC/QhCYHFL+8qRLNYIyyvwKgEstwndvQz6AiAOWtFTH892BJh4OMvaqCKAPfbMfRQA6xiOxsvv6Fg16wVbjMjCOMa3cl0YwlH1BeYTXmu0IWYsjkFp8eVcUWaAVnIer+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e06oZof8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VQsq/C5p; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=E0LF1M/E; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oCaC+Wr8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e06oZof8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VQsq/C5p";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="E0LF1M/E";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oCaC+Wr8"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DFA4C66DFD;
	Wed,  3 Jun 2026 01:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780448851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=urCdgPy5rcN+OekZ0PW2Hi/WHfCxSDyrgnbL7//0/q4=;
	b=e06oZof8zJ1oKBm9X+Y+X3YhuIwjkPk1Kd0OIXztxDMKJwzVeMYNi8VbAs9HQk7qh7HGbt
	pLFzk/niaaGxZIiKtxxVGbhjhgjyQXKqJhgxU0UWEuCq08ikESX2mbYnLoOwSIQxv9bn3g
	yiIRdHrFsmbMq34n5bNM+UqTfwR4SyU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780448851;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=urCdgPy5rcN+OekZ0PW2Hi/WHfCxSDyrgnbL7//0/q4=;
	b=VQsq/C5pFRItWrbbHu5y0E4A1Y3uL8EHdy81024KNomxuRjLFx/qag/kOFM+4m744ycsdC
	CLT00B4snVIzRQBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="E0LF1M/E";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=oCaC+Wr8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780448850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=urCdgPy5rcN+OekZ0PW2Hi/WHfCxSDyrgnbL7//0/q4=;
	b=E0LF1M/E4yIvvrwGTndm16ThRdGoWm4O2px0GlGwY7cqD6APuBBDexA+zBhZaQdQBK2jYr
	jnADfGNKDQWfv4AAxP8m9IWZOkUdRi/rvAsSXSSkosQyguccK2EKahFEoVSrW4QKEhJzcZ
	zaYTMGtY5krjphOjr0o9jNMPb0+qZZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780448850;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=urCdgPy5rcN+OekZ0PW2Hi/WHfCxSDyrgnbL7//0/q4=;
	b=oCaC+Wr85xacU1Z/AP1TcLP1cjFc6W83FGvrKZsx/S04ILfeOJ3W4sURryv4+WjUmCRFKY
	fyIwzYOunDkZxmDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A0A1D779A7;
	Wed,  3 Jun 2026 01:07:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aV6gGlF+H2rNSAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 03 Jun 2026 01:07:29 +0000
Message-ID: <f1520a48-f01a-4324-acec-3569ac8541e8@suse.de>
Date: Wed, 3 Jun 2026 03:07:06 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] A block level, active-active replication
 solution
To: Philipp Reisner <philipp.reisner@linbit.com>,
 Haris Iqbal <haris.iqbal@ionos.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org,
 Jia Li <jia.li@ionos.com>
References: <CAJpMwyiVqqbR3ni+URv0uPnE0Bgt_+d+-_+_t6E3wzfiUOT-cg@mail.gmail.com>
 <afm2PewS5Gi5QU61@ryzen9>
 <CAJpMwyjcUc7n9g0YMbpBPZorUOiyseBOHHKoUhYDriEu5gzLEg@mail.gmail.com>
 <CADGDV=USt71WBRAXXmwEERqQp0fpk7QPaOyrZjkGXpnY_yYSCQ@mail.gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <CADGDV=USt71WBRAXXmwEERqQp0fpk7QPaOyrZjkGXpnY_yYSCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: DFA4C66DFD
X-Spam-Score: -4.51

On 6/1/26 14:26, Philipp Reisner wrote:
> On Wed, May 27, 2026 at 2:16 PM Haris Iqbal <haris.iqbal@ionos.com> wrote:
>>
>> On Tue, May 5, 2026 at 11:20 AM Philipp Reisner
>> <philipp.reisner@linbit.com> wrote:
>>>
>>> Am Tue, Feb 03, 2026 at 04:09:59PM +0100 schrieb Haris Iqbal:
>>>> Hi Haris,
>>>>
>>>> We are working on a pair of kernel modules which would offer a new
>>>> replication solution in the Linux kernel. It would be a block level,
>>>> active-active replication solution for RDMA transport.
>>>>
>>>> The existing block level replication solution in the Linux kernel is
>>>> DRBD, which is an active-passive solution. The data replication in
>>>> DRBD happens through 2 network hops.
>>>>
>>>>
>>>> An active-active solution which one can build is by exporting block
>>>> devices, either through NVMeOF or RNBD/RTRS, over the network, and
>>>> then creating a raid1 device over it. It would provide a single hop
>>>> replication solution, but the synchronization during a degraded state
>>>> goes through 2 hops.
>>>>
>>>> The proposed solution would provide an active-active single hop
>>>> replication, and a single hop synchronization (directly between
>>>> storage nodes) in case of a degraded state.
>>> [...]
>>>
>>>
>>> I stumbled across this post because of the newer replies.
>>>
>>> I want to point out that we have significantly developed DRBD over the
>>> last 15 Years as an out-of-tree module. In the past months, we began
>>> the process of getting all those improvements back into Linux
>>> upstream.
>>>
>>> With that, DRBD9 became multi-node. It does the “active-active single
>>> hop replication” as it is. The networking part is now abstracted into
>>> transport modules. We have one for TCP, one for load balancing across
>>> multiple TCP connections, and one for RDMA.
>>>
>>> What you are doing here, in DRBD lingo, is a diskless primary
>>> connected to multiple storage nodes.
>>>
>>> Find everything here https://github.com/LINBIT.
>>> The latest edition of what we bring to the upstreaming discussion:
>>> https://github.com/LINBIT/linux-drbd/tree/drbd-next
>>
>> Hi Philipp,
>>
>> Interesting.
>> I looked into the diskless primary mode configuration for DRBD, and it
>> does look similar to what RMR/BRMR offers.
>> We plan to do comparison runs of DRBD diskless primary mode, and RMR/BRMR.
>>
>> I see the DRBD version in the current kernel is still 8.x.x.
>> Do you have an ETA by when can we have version 9 in the kernel?
>>
> 
> Hi Haris,
> 
> We are working on it. We are currently aligning the way we do things
> with Generic Netlink. We are aligning our code to follow the upstream
> conventions,
> and the .YML and code generator used nowadays in this area.
> 
> If we are not discovering another area where similar cleanups are necessary,
> I expect that we will submit it in August.
> 
A round of applause for that effort. We have been waiting for that for a 
long time.
Thanks Philipp!

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
