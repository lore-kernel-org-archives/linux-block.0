Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9998622E3FA
	for <linux-block@vger.kernel.org>; Fri, 11 Jul 2025 20:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752266783; cv=none; b=QBtsHvmgFDn2lBi5gFODDz95bH74E0A2nmhRar2IT9pGyeWPZT6LdXhPWBREUUFocLKUaoVDbqNStL+qIM238T8ntWHgz/7FDmLQDzcBAKB7doqp21fX+6PVZLP15npbFcCZjiZhX1J/egIpaTNhjAemKlR6OXw1N5debmr1E2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752266783; c=relaxed/simple;
	bh=AAlz/UNfwYp2GvbLqNZX+BzmyQ99uNNeAi7y95YMYr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxqVK/1sA1/+px5ZQo8wt5QbusN1L7Qin5wad8kag4GGHkPjCZ6UCVgY517zvZNQH3d7b4YoAHmJsU3aEAsOrPYzs5P6Cv2sKdpbUcgJNFzRS82KRvOOcpCKuZoFhw5vkHK0aP/qS7fCW0CkAHhlPwrmZ7HNK4z6v93Ylh6OqqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk; spf=pass smtp.mailfrom=philpotter.co.uk; dkim=pass (2048-bit key) header.d=philpotter-co-uk.20230601.gappssmtp.com header.i=@philpotter-co-uk.20230601.gappssmtp.com header.b=XpVhQpsD; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20230601.gappssmtp.com header.i=@philpotter-co-uk.20230601.gappssmtp.com header.b="XpVhQpsD"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a50fc7ac4dso1215675f8f.0
        for <linux-block@vger.kernel.org>; Fri, 11 Jul 2025 13:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20230601.gappssmtp.com; s=20230601; t=1752266780; x=1752871580; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V16pgEq2LoIwxvVcW28uJdtUBFBodUNrvMVaP4CH9y8=;
        b=XpVhQpsDYW/StxLnKydvD71/oQyFMsrwK4g5pTnBXeFG1zuhGLVyHQjahkwGTrp9K9
         3LtFXyFi/Sjo1aA5/UH/vHb3RA8SZL2c1ecdWAzyTumDXV+SpqY7K6C9xWUsoit8M+OV
         o+GFwcoeFnx/LgExkmpEDQWFaKvsJKPp6PaivI7o7pQu4o12pEda3oKcyQaHe5zeLkXy
         J7MUj+nDOxjw7DFlot4pXWTnfvlo5gDmiBF+aymmxBo9+x5qAAZFN4bEkl51/8QI6wyF
         cT+nb2pTVE2eZ0nyijU+JAtHp2BPpDJI/ffcYkaPA3k7iNcb3WHi/tfkDw27bFOVKP+7
         eYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752266780; x=1752871580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V16pgEq2LoIwxvVcW28uJdtUBFBodUNrvMVaP4CH9y8=;
        b=bAzUyS7Wx6eHzc0mH7kAmmjz5LKZBCKng9hJw+4z/Z7y0/HQcwk6D78kK7KzC8fy8x
         406OGcmaWcqEvINEP7kAfylO0q9yTElXs0aBBItCZTxadyj4ntCcGTkmHj6iSUAVI0fh
         W7WvukpNWXo1aFwUiaeS9SZ9A+7Ptdv75hjrIUJLe8ABpofhxq44I3jklNtR41+GDZWL
         2s1zTHi5ti9vYk4lFrYiqTh3D5ZWVY0xWw790ltTMtSzIP1QIUkAsWqn8PV19znnd8nX
         zt92TF34F39l94zOKZKaT+wQVayTYoo4KOq7+yzbi+TQ4qcmsZgzqzfDgDitm/LryWIs
         Jc3A==
X-Forwarded-Encrypted: i=1; AJvYcCXhI2T8XSny4hS01ufh5JL6VdXxusEVzoeqfgC9XdkrzkkDIBo4VNlig1/UkLRg+SzLEeXQcBJBDp/8oA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxwwJSn0Jwnc/zpeUAQJuLEEQCn46pJrgaXEfkTHM55NYYEPPdo
	EETtUHH5UfGOTsYwkpo1Sj148GZlJUxndS3pp9WZ0AeuHnZstdf4yLYgQq5g/xjn/Ok=
X-Gm-Gg: ASbGncte9M9xhXPz8Kkql/5S8EaOKT2Ddp/IUYW+z0+IBtkUlD+yfLqDwd+93ULRZEC
	TxjxRIRdV9lhMSlJcgZQXdE5NmZ/HElzgb4egojQaNkdiXN/ZW6IYmjbdvwVEHEvqBLZIWTrROz
	1+JmJluyfn8xbi4nB5pjYtRiuGGkKLPuYCiMf04Q/+3KHx8E1cdv15BUeOU53cmHYEahvVzFpWW
	zy7gsXzsF8sxBsFCo4Tyos2XZ0zB0NXxI6xTQCpR6EIxWPxocIo1C6wIU1nnVwxBQDD/HwC4tQp
	JY3NTFVRvLF5T0RpGBgac0p+221Tm5XZDGNWkFI7Sr+mw1ROt9RVluMlKSqeMSsAApZoof0kNQW
	5jGoFfA3ctmG7bOWgdLFfikl3GOc/ieKjoEi2UJx/qdVQIncDW44sTyxfV+7cLNxFdExJhu5+nu
	GguSbA
X-Google-Smtp-Source: AGHT+IHTqWllTe4YdW70kMG3P51HzHNZlYKrDtpT/RTO+NBYzPUEJ4+H3/CabZ+iQn7Kw1/H5a/Z0w==
X-Received: by 2002:a5d:4083:0:b0:3a5:3b14:1ba3 with SMTP id ffacd0b85a97d-3b5f18d3732mr3637814f8f.49.1752266779749;
        Fri, 11 Jul 2025 13:46:19 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e25e75sm5349311f8f.87.2025.07.11.13.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 13:46:19 -0700 (PDT)
Date: Fri, 11 Jul 2025 21:46:17 +0100
From: Phillip Potter <phil@philpotter.co.uk>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	Chris Rankin <rankincj@gmail.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Phillip Potter <phil@philpotter.co.uk>
Subject: Re: cdrom: cdrom_mrw_exit() NULL ptr deref
Message-ID: <aHF4GRvXhM6TnROz@equinox>
References: <uxgzea5ibqxygv3x7i4ojbpvcpv2wziorvb3ns5cdtyvobyn7h@y4g4l5ezv2ec>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <uxgzea5ibqxygv3x7i4ojbpvcpv2wziorvb3ns5cdtyvobyn7h@y4g4l5ezv2ec>

On Fri, Jul 11, 2025 at 04:04:17PM +0900, Sergey Senozhatsky wrote:
> Hi,
> 
> We are seeing the same NULL ptr deref upon cdrom release, as reported
> in [1] (Chris Cc-ed) in our fleet.  Currently on 6.6 LTS (could be the
> same for older kernels as well, I didn't check.)
> 
> Phillip, is this a known issue?
> 
> <1>[335443.339244] BUG: kernel NULL pointer dereference, address: 0000000000000010
> <1>[335443.339262] #PF: supervisor read access in kernel mode
> <1>[335443.339268] #PF: error_code(0x0000) - not-present page
> <6>[335443.339273] PGD 0 P4D 0
> <4>[335443.339279] Oops: 0000 [#1] PREEMPT SMP NOPTI
> <4>[335443.339287] CPU: 1 PID: 1988 Comm: cros-disks Not tainted 6.6.76-07501-gd42535a678fb #1 (HASH:7d84 1)
> <4>[335443.339301] RIP: 0010:blk_queue_enter+0x5a/0x250
> <4>[335443.339312] Code: 03 00 00 4c 8d 6d a8 eb 1c 4c 89 e7 4c 89 ee e8 8c 62 be ff 49 f7 86 88 00 00 00 02 00 00 00 0f 85 ce 01 00 00 e8 86 10 bd ff <49> 8b 07 a8 03 0f 85 85 01 00 00 65 48 ff 00 41 83 be 90 00 00 00
> <4>[335443.339318] RSP: 0018:ffff9be08ab03b00 EFLAGS: 00010202
> <4>[335443.339324] RAX: ffff8903aa366300 RBX: 0000000000000000 RCX: ffff9be08ab03cd0
> <4>[335443.339330] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> <4>[335443.339333] RBP: ffff9be08ab03b58 R08: 0000000000000002 R09: 0000000000001b58
> <4>[335443.339338] R10: ffffffff00000000 R11: ffffffffc0ccd030 R12: 0000000000000328
> <4>[335443.339344] R13: ffff9be08ab03b00 R14: 0000000000000000 R15: 0000000000000010
> <4>[335443.339348] FS: 00007d52be81e900(0000) GS:ffff8904b6040000(0000) knlGS:0000000000000000
> <4>[335443.339357] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4>[335443.339362] CR2: 0000000000000010 CR3: 0000000140ac6000 CR4: 0000000000350ee0
> <4>[335443.339367] Call Trace:
> <4>[335443.339372] <TASK>
> <4>[335443.339379] ? __die_body+0xae/0xb0
> <4>[335443.339389] ? page_fault_oops+0x381/0x3e0
> <4>[335443.339398] ? exc_page_fault+0x4f/0xa0
> <4>[335443.339404] ? asm_exc_page_fault+0x22/0x30
> <4>[335443.339416] ? sr_check_events+0x290/0x290 [sr_mod (HASH:ab3e 2)]
> <4>[335443.339432] ? blk_queue_enter+0x5a/0x250
> <4>[335443.339439] blk_mq_alloc_request+0x16a/0x220
> <4>[335443.339450] scsi_execute_cmd+0x65/0x240
> <4>[335443.339458] sr_do_ioctl+0xe3/0x210 [sr_mod (HASH:ab3e 2)]
> <4>[335443.339471] sr_packet+0x3d/0x50 [sr_mod (HASH:ab3e 2)]
> <4>[335443.339482] cdrom_mrw_exit+0xc1/0x240 [cdrom (HASH:9d9a 3)]
> <4>[335443.339497] sr_free_disk+0x45/0x60 [sr_mod (HASH:ab3e 2)]
> <4>[335443.339506] disk_release+0xc8/0xe0
> <4>[335443.339515] device_release+0x39/0x90
> <4>[335443.339523] kobject_release+0x49/0xb0
> <4>[335443.339533] bdev_release+0x19/0x30
> <4>[335443.339540] deactivate_locked_super+0x3b/0x100
> <4>[335443.339548] cleanup_mnt+0xaa/0x160
> <4>[335443.339557] task_work_run+0x6c/0xb0
> <4>[335443.339563] exit_to_user_mode_prepare+0x102/0x120
> <4>[335443.339571] syscall_exit_to_user_mode+0x1a/0x30
> <4>[335443.339577] do_syscall_64+0x7e/0xa0
> <4>[335443.339582] ? exit_to_user_mode_prepare+0x44/0x120
> <4>[335443.339588] entry_SYSCALL_64_after_hwframe+0x55/0xbf
> <4>[335443.339595] RIP: 0033:0x7d52bea41f07
> 
> [1] https://lore.kernel.org/all/CAK2bqVJGsz8r8D-x=4N6p9nXQ=v4AwpMAg2frotmdSdtjvnexg@mail.gmail.com/

Hi Sergey,

I have not been aware of this issue until now, as it pertains to the Uniform
CD-ROM driver, wasn't copied on the original bug report. Happy to do some
debugging by all means though. Please could you give me some more information
about how you're triggering it - i.e. is it particular discs? I am grateful
for any information you can provide.

Regards,
Phil
