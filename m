Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F001F94D
	for <linux-block@vger.kernel.org>; Thu, 22 May 2025 13:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747922352; cv=none; b=s3nHHk89Wf6AEqofJqj4XbThfdFCMJjEMH4/nvTf1vMbzsi+6ARq4Ozba7Mc7MkSaImtzGZhxoUct1Z19qsv1uC4CCdbltrcVoKQBW82/b354EhYlhREN0i5Y/gHusns0XKuRalJ1UKIJD6AvSPEuMjrR3IfPatPdA8MN35Q3MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747922352; c=relaxed/simple;
	bh=sOw69SMPJxq0Gnf2Oh52R1YNDJ5a7OB7S4uGHzaDwz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HaaOO4bpURtOwPb+rCBiiUnqzAIBhP3YjlFiBrflnfQCyHIQV4Ay0XEfBSGedzV0tKMGHpEbzx0QpKm2zRvVrrf6QQG4AdWjOKOc6EHbEMgQkuXVSYPcknYNndhWcaUM2YQzkG8yIHIliR35ktoB3yvrOB4ApKCzutxG4tAPIVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Sc6TmsmX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=32M51D0T; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Sc6TmsmX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=32M51D0T; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Sc6TmsmX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="32M51D0T";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Sc6TmsmX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="32M51D0T"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 83AED1F460;
	Thu, 22 May 2025 13:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747922348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kUu2tvAxGUJdCeVnccCqWAoYjCWauMy0PUQ37gdYwaQ=;
	b=Sc6TmsmX9EYQK0KAffCif9SmbCyu7EvOC+njEM1inB77vTmZpWLhzdzLIpTXsofsS8lQWd
	GXSwO6KLLe17nsTf3K4Y6HVOEkKgCWkEME05AiKRfvNNE2onojrGSyIcPXvsz3zg+kl0pq
	ghEt0c7CJXUgudOC2gsq4zrMpOl36s8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747922348;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kUu2tvAxGUJdCeVnccCqWAoYjCWauMy0PUQ37gdYwaQ=;
	b=32M51D0TPITn6ThDzi7JjYFNbRjfa9z+NnEDRflhjlL3jo98j6sEZQNcxJTAEflmVAVD41
	fnceVO/Rl2RIh8CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747922348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kUu2tvAxGUJdCeVnccCqWAoYjCWauMy0PUQ37gdYwaQ=;
	b=Sc6TmsmX9EYQK0KAffCif9SmbCyu7EvOC+njEM1inB77vTmZpWLhzdzLIpTXsofsS8lQWd
	GXSwO6KLLe17nsTf3K4Y6HVOEkKgCWkEME05AiKRfvNNE2onojrGSyIcPXvsz3zg+kl0pq
	ghEt0c7CJXUgudOC2gsq4zrMpOl36s8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747922348;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kUu2tvAxGUJdCeVnccCqWAoYjCWauMy0PUQ37gdYwaQ=;
	b=32M51D0TPITn6ThDzi7JjYFNbRjfa9z+NnEDRflhjlL3jo98j6sEZQNcxJTAEflmVAVD41
	fnceVO/Rl2RIh8CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 679C4137B8;
	Thu, 22 May 2025 13:59:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bmJ9GKwtL2h+DQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 22 May 2025 13:59:08 +0000
Message-ID: <a67c2d17-216c-4e41-be53-09200f590896@suse.de>
Date: Thu, 22 May 2025 15:59:08 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] nvmet: implement copy support for bdev backed target
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-6-kbusch@meta.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250521223107.709131-6-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]

On 5/22/25 00:31, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The nvme block device target type does not have any particular limits on
> copy commands, so all the settings are the protocol's max.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   drivers/nvme/target/io-cmd-bdev.c | 52 +++++++++++++++++++++++++++++++
>   1 file changed, 52 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
