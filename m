Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E5818B0A
	for <linux-block@vger.kernel.org>; Fri,  6 Feb 2026 00:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770336388; cv=none; b=F+WEWHrIH0H1IMVsiutCG3Fqp5+jTTxfxEmLe/XJjb1B3mkqjIjXljf3eldKqUK+fDLuLSUa57Pq//1/o+weog8RJd8ef25AtQwsui4KPgtR4iIkyxu1tGTYjkj+xt6p0I+0Th1cJwlWsdJmzZ+9G8PuFI6+EGpmVFc4XUkMycE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770336388; c=relaxed/simple;
	bh=RddzYL5/VZpga5F0+y6gsWTH3W4nYTvVNpLT7Mctepk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ud7NDBe2lJ5abLtAGXPgU8akdT0pdTuzgUDoCE1omMTDLu9o2xIls5ojmR1YwU0LI2yM9Y55KBn6NfnFZyVIfsLWLjgDRFp2aVYHvnYlBmRjJCX9awLYaEYsZ+ASnwDMdFJ7MW/gnGuM85ncBSnLpHKQCLibb/fv58teWFXYzVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qmweUoC3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0JGxQlGV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qmweUoC3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0JGxQlGV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qmweUoC3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0JGxQlGV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qmweUoC3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0JGxQlGV"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CEA503E6D2;
	Fri,  6 Feb 2026 00:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770336386; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lQ174v65POXMgRMW31Q2kTybtxHt9RrB/kkcm5b+B6E=;
	b=qmweUoC3N70J9GJlyK2SJ2x+Nw3an8Wxcux/1RaMJ+El3HRIGirjHvtM5TCYySsCg7cRmN
	vXWstFrak1rE/VI6dvxTjonQBdTCX9YolSMskuZiWDViGoWp+7+CncS5LGLefGwApZkGfE
	ptaV0SyWMvoByGJ9SlHbRzZj7Kevoak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770336386;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lQ174v65POXMgRMW31Q2kTybtxHt9RrB/kkcm5b+B6E=;
	b=0JGxQlGVmYQQSKFxB5Ke5oedCYcSw8acnRauMxBSAiR7eeRdvadPt+1uyhXZcFVnyB9CtC
	u2ESS5qVjJvRrGCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770336386; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lQ174v65POXMgRMW31Q2kTybtxHt9RrB/kkcm5b+B6E=;
	b=qmweUoC3N70J9GJlyK2SJ2x+Nw3an8Wxcux/1RaMJ+El3HRIGirjHvtM5TCYySsCg7cRmN
	vXWstFrak1rE/VI6dvxTjonQBdTCX9YolSMskuZiWDViGoWp+7+CncS5LGLefGwApZkGfE
	ptaV0SyWMvoByGJ9SlHbRzZj7Kevoak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770336386;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lQ174v65POXMgRMW31Q2kTybtxHt9RrB/kkcm5b+B6E=;
	b=0JGxQlGVmYQQSKFxB5Ke5oedCYcSw8acnRauMxBSAiR7eeRdvadPt+1uyhXZcFVnyB9CtC
	u2ESS5qVjJvRrGCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E4ED33EA63;
	Fri,  6 Feb 2026 00:06:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id u0bLJYAwhWkUIQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 06 Feb 2026 00:06:24 +0000
Message-ID: <92a1fd89-68ef-4dea-8c49-df3370f63daa@suse.de>
Date: Fri, 6 Feb 2026 01:06:18 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] sed-opal: add Admin1PIN parameter.
To: Ondrej Kozina <okozina@redhat.com>, linux-block@vger.kernel.org
Cc: gmazyland@gmail.com, jonathan.derrick@linux.dev, gjoyce@ibm.com
References: <20260130162527.570255-1-okozina@redhat.com>
 <20260205150935.238137-4-okozina@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260205150935.238137-4-okozina@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,ibm.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-Spam-Level: 
X-Spam-Flag: NO

On 2/5/26 16:09, Ondrej Kozina wrote:
> As desribed in ch. 3.1.1.1.1.3 of TCG Storage Opal SSC Feature Set:
> Single User Mode document.
> 
> To be used later in Reactivate method implementation.
> 
> Signed-off-by: Ondrej Kozina <okozina@redhat.com>
> ---
>   block/opal_proto.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/block/opal_proto.h b/block/opal_proto.h
> index b9877eacfe91..3ccee5977c10 100644
> --- a/block/opal_proto.h
> +++ b/block/opal_proto.h
> @@ -226,6 +226,7 @@ enum opal_lockingstate {
>   enum opal_parameter {
>   	OPAL_SUM_SET_LIST = 0x060000,
>   	OPAL_SUM_RANGE_POLICY = 0x060001,
> +	OPAL_SUM_ADMIN1_PIN = 0x060002,
>   };
>   
>   enum opal_revertlsp {

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
