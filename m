Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6451712E5D
	for <linux-block@vger.kernel.org>; Mon, 23 Sep 2024 06:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727073084; cv=none; b=oFxONmf1ztIuPhq9xlIR8+mfGrRExEpDq4gJN4SpdaLKe6H2Yva1HmjblUmPOdxqs6aW38Cqb3gz5IGd1HzI/keRUoE3xLbxt/pjPdUNmYvdNXvVrV1K0gIi1I2Fbd86ed2+Rw87SvbFNHUqTirAIrTCuJNKdQkhaAuVoeceXOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727073084; c=relaxed/simple;
	bh=OcCJeJobHZzrowTHzZsblmR57klSEu9XCB+udNj/aEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Er4mznpguw1wmFm7GT7C4JqrSLsMgRkQuRQEUEwmjqn7c9qbqXtFgEcp1rny1TPEo2UW27UwCxz/ZsX7MhLkDW9g2k3mYKGRSNtn4h43NfGHNHagnvsnzZFbUeshCOFIv/NIeIyBivf5L4zt4uNtmNJwsa40FO9FreUZ8k8n+RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0rzrLt75; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jgLB6hTt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QN0BAD33; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mv4qvUXl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0rzrLt75";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jgLB6hTt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QN0BAD33";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mv4qvUXl"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DC02C1FB50;
	Mon, 23 Sep 2024 06:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727073080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BTyjzRLqT6ZbaWunnClfylzQNdAVF2Mg5wFTiBIIHrs=;
	b=0rzrLt75LcQYr/WzoBQ0Bev39qRtqePH7yQK5lcT4//KcUyXshkIuJQbsyxicQgw3t+mJp
	mhxsORUKNK0haGPSprJ3XlP2NXapzW+Vm2E+/wbAVldx2HAVTU+73HoulqL0C4HzNx3exx
	m+SXfnk2ARmS8F1srnQleaiSGejRzoM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727073080;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BTyjzRLqT6ZbaWunnClfylzQNdAVF2Mg5wFTiBIIHrs=;
	b=jgLB6hTtgkem/NUPRpOp3lV69DN4gq4WXbBvU9X+ZXsOu5ifDuSyGGpHsm2hvcDDEj+T3k
	0w/CdmrN3VmYLTDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QN0BAD33;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mv4qvUXl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727073079; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BTyjzRLqT6ZbaWunnClfylzQNdAVF2Mg5wFTiBIIHrs=;
	b=QN0BAD33Iyg/bOxzkoNWDV4I3Ft2bL3grKX0msKHDNUlLEXnhnOIvTu244cD22vh4wd5uj
	MP0+wgnC8MJaIFAyN6F2dBvmTAkRe3EupnbRnNoF4DdVMQNRD0rGQi1s+cAe9czEJQ0/Po
	n+79qR+EBQL3AmXrRyVuX0D3n8ftvcw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727073079;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BTyjzRLqT6ZbaWunnClfylzQNdAVF2Mg5wFTiBIIHrs=;
	b=mv4qvUXlnym0h+B3P1DuvZmBKnGXsAKnoT0TRm6uVEZPqP+laQW10x0EzO14qQIitrgvb7
	aCUHTPs5wNHJktBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A45513A64;
	Mon, 23 Sep 2024 06:31:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zvU9IzcL8WZCTgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 23 Sep 2024 06:31:19 +0000
Message-ID: <5ce3b803-275d-4be3-a9bc-87d06a8f5033@suse.de>
Date: Mon, 23 Sep 2024 08:31:19 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report][regression][bisected] most of blktests nvme/tcp
 failed with the last linux code
To: Yi Zhang <yi.zhang@redhat.com>, linux-block
 <linux-block@vger.kernel.org>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <CAHj4cs90xV1t2NbV6P3_z1oYwD0BcvMhC5V2mGgekRq8iae=NA@mail.gmail.com>
 <CAHj4cs8YGgmemMZDXmt7yHa+Xq3EiEvRWOJGEQTDjqGB2rAogw@mail.gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <CAHj4cs8YGgmemMZDXmt7yHa+Xq3EiEvRWOJGEQTDjqGB2rAogw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DC02C1FB50
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	TO_DN_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 9/20/24 16:20, Yi Zhang wrote:
> + Hannes
> I did bisect and it seems was introduced with the below commit:
> 
> commit 1e48b34c9bc79aa36700fccbfdf87e61e4431d2b
> Author: Hannes Reinecke <hare@suse.de>
> Date:   Mon Jul 22 14:02:22 2024 +0200
> 
>      nvme: split off TLS sysfs attributes into a separate group
> 
> 
> On Thu, Sep 19, 2024 at 12:09 AM Yi Zhang <yi.zhang@redhat.com> wrote:
>>
>> Hello
>>
>> CKI reported most of the blktests nvme/tcp tests failed on the linux
>> tree[1], here is the reproducer and dmesg log, the issue cannot be
>> reproduced with 6.11.0, seems
>> it was introduced with the latest block code merge, please help check
>> it and let me know if you need any info/testing about it, thanks.
>>
>>
>> [1]
>> https://datawarehouse.cki-project.org/kcidb/tests/14394423
>>
>> [2]
>> # nvme_trtype=tcp ./check nvme/003
>> nvme/003 (tr=tcp) (test if we're sending keep-alives to a discovery
>> controller) [failed]
>>      runtime  11.280s  ...  11.188s
>>      --- tests/nvme/003.out 2024-09-18 11:30:11.243366401 -0400
>>      +++ /root/blktests/results/nodev_tr_tcp/nvme/003.out.bad
>> 2024-09-18 11:52:32.977112834 -0400
>>      @@ -1,3 +1,3 @@
>>       Running nvme/003
>>      -disconnected 1 controller(s)
>>      +disconnected 0 controller(s)
>>       Test complete
>> # dmesg
>> [  447.213539] run blktests nvme/003 at 2024-09-18 11:52:21
>> [  447.229285] loop0: detected capacity change from 0 to 2097152
>> [  447.233104] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
>> [  447.242398] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
>> [  447.251089] sysfs: cannot create duplicate filename
>> '/devices/virtual/nvme-fabrics/ctl/nvme0/reset_controller'
>> [  447.251810] CPU: 2 UID: 0 PID: 5241 Comm: nvme Kdump: loaded Not
>> tainted 6.12.0-0.rc0.adfc3ded5c33.2.test.el10.aarch64 #1
>> [  447.252540] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
>> [  447.253006] Call trace:
>> [  447.253171]  dump_backtrace+0xd8/0x130
>> [  447.253432]  show_stack+0x20/0x38
>> [  447.253657]  dump_stack_lvl+0x80/0xa8
>> [  447.253925]  dump_stack+0x18/0x30
>> [  447.254152]  sysfs_warn_dup+0x6c/0x90
>> [  447.254406]  sysfs_add_file_mode_ns+0x12c/0x138
>> [  447.254713]  create_files+0xa8/0x1f8
>> [  447.254973]  internal_create_group+0x18c/0x358
>> [  447.255274]  internal_create_groups+0x58/0xe0
>> [  447.255558]  sysfs_create_groups+0x20/0x40
>> [  447.255826]  device_add_attrs+0x19c/0x218
>> [  447.256093]  device_add+0x310/0x6d0
>> [  447.256327]  cdev_device_add+0x58/0xc0
>> [  447.256579]  nvme_add_ctrl+0x78/0xd0 [nvme_core]
>> [  447.256895]  nvme_tcp_create_ctrl+0x3c/0x178 [nvme_tcp]
>> [  447.257248]  nvmf_create_ctrl+0x150/0x288 [nvme_fabrics]
>> [  447.257614]  nvmf_dev_write+0x98/0xf8 [nvme_fabrics]
>> [  447.257948]  vfs_write+0xdc/0x380
>> [  447.258174]  ksys_write+0x7c/0x120
>> [  447.258408]  __arm64_sys_write+0x24/0x40
>> [  447.258673]  invoke_syscall.constprop.0+0x74/0xd0
>> [  447.258994]  do_el0_svc+0xb0/0xe8
>> [  447.259225]  el0_svc+0x44/0x1a0
>> [  447.259449]  el0t_64_sync_handler+0x120/0x130
>> [  447.259745]  el0t_64_sync+0x1a4/0x1a8
>>
>> --
>> Best Regards,
>>    Yi Zhang
> 
> 
> 
How utterly curious.
This mentioned patch moves some sysfs attributes to a different location 
in the code. The stacktrace you've posted indicates that we're creating 
a controller while the previous one is still present in sysfs, ie that 
the lifetime of the controller has changed.
I find it difficult to understand how the cited path could have changed
the lifetime of the controller object, but will continue to check.

Does the error disappear if you just revert the cited patch?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

