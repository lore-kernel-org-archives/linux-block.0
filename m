Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD6422127C
	for <linux-block@vger.kernel.org>; Mon, 14 Jul 2025 22:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752533852; cv=none; b=PR9paZsA+lxtGtwjP3OE5mrJUt96UmjGBgQDQk1LhDlBfNPPp70ccxclSXBNxxmjGEMHdCJTv/qcR8jK6nOccF2NSk/ctKOt5ep2br1Yu7KQs3slzhSeaeoN56jYsl7MguAaoboKsW6Ym7102vgaKh3TCLnaRn/qlyZ1WE8DTIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752533852; c=relaxed/simple;
	bh=RPepvfdw1T40/WLEcjIcvClChehDLty8SFzoyGixb68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NxXFam0wMenbsnWFU8SVEvidAcdsdDCRF/n+0I2Yiyj5ujAuTHERGPkEG0P+iWabsxctDdKTz6lnRhdU+Cd4w30w6ocdqPDQvwS9K1qxnYAkPWl2V/jf0L8bOY5OrS1FFLEn4OlfHGwvYJu9fjsBLzs/CXttIZ+DXDQptBAOgWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk; spf=pass smtp.mailfrom=philpotter.co.uk; dkim=pass (2048-bit key) header.d=philpotter-co-uk.20230601.gappssmtp.com header.i=@philpotter-co-uk.20230601.gappssmtp.com header.b=H+BJzGCR; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20230601.gappssmtp.com header.i=@philpotter-co-uk.20230601.gappssmtp.com header.b="H+BJzGCR"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a53359dea5so2563455f8f.0
        for <linux-block@vger.kernel.org>; Mon, 14 Jul 2025 15:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20230601.gappssmtp.com; s=20230601; t=1752533849; x=1753138649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HZyWJXWZTM1WL9ropJiWAFVoVEj0nCtS0kYXtGIpaws=;
        b=H+BJzGCRxxa5ZKKqcq4FJi4kZ9TGjQjrRbHogQk4fIZtL49zjEMU0L6QHflDltsKXW
         s9twhFVuxdhFEjDYsuJ1ibz0EXr2rJvW8abBssGFFgc4eksLfNS4lRSAMqR3en9b5NJS
         SMR/kG6oH2h5Rmr9AbfEUBpPLD6NPSmTTzv3kIZRJoAR1SEx+jpkbXftEdEezdmKonIt
         CG5s1ozspvxq8jxIYu/Wx8hh6vCqdgI9QJajaSpHvE9uLSQfOeaQJH3FsoNTK0uGaev/
         mgjCX5yhR8ta2K2dgQcL1RBbEsRN67PZYs4/xXvc3+ez8dezO4dKIKl5pLR8aRgmlKj1
         s1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752533849; x=1753138649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZyWJXWZTM1WL9ropJiWAFVoVEj0nCtS0kYXtGIpaws=;
        b=RvPzLQr4vzjpESqq2n9QBSj3o5bNL6t0Id44dUfTs6r6PQHiZjrhZY9oPGGGhYmByN
         6ilzhPD8UWLkl6S68XAonMnC6nqjj/jzMjKhJxB6RuBrNFifsIl3V9WHNZsK7b3sHKqg
         1/nACE+i0m3E1LRw7oRHL88swGCBSwACqb26r6yuQyA0rwXgY+xDT+oA9lMxV+3bEIQe
         M+H76tOtwRAT94hIhcEHu3DL1fXf7fACj4oALLm0IyuVfmpyBcbV2TlNTcb5EhDzsDhZ
         +1CsX5MpAZp71X2jvguNoDgFxSR9lhAh3YVcFCEAkyTIayF7md26EAIN6/hm1V2pUea8
         X3Mw==
X-Forwarded-Encrypted: i=1; AJvYcCVG+UyOAmaoc0UN+f6921Yz/voK4zYUwLW/rLFjjHvKNAMCDE90DIGB765qPABzOUgC1Vqmlv+ny0s/eA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNfz2uJ1GUrLlfM3llGtxc7xAu5TEVkKvy7b1EGOGEYoeSprBE
	AZYnOAJ2pvoQ087serX2aj+L81F7Q7TzNerMs4Wi7a4YG9TSaVDHsMPRkbhyzNrm89A=
X-Gm-Gg: ASbGncudUHcPLxn2lJKMC+vVKj6cR0m067XDacBAy0vpJotjTT8k/nFC5XbzS/05/rE
	9TtEebU5MSSuPs1tMAphIXzjyHd4LSXNC3kk61yVFrr5BmQ/4e9G1ZwW8ACXvVWgJIsJlkj3TrI
	Jx9Abncz90XFq08XqcjQ/0kZKeCpuPqndgmrbao/2ybrD42QpkVry0wVgzB8OFC6PmNOyHJMuwW
	TEQD+n1ajAT3nIuDpzXtn5V+BC7Rs3z4FQLsTm4/4QDIFGa15dAUc/u4jv6dSVA1vPmP0TzGxOx
	+eCjXH5nBQiiF8S35Qus7Stmb97hGCs9ZLCabb08NavMjkUpvfXYvb/mNBR2UjP3/oHvX7E9VFd
	S0FkwLjEWc2arlJyKW/NGMXOKmgUsdKOPBCrl7a/twwJUO66oc/3+megGJRVuRb8+wJNcg4zEZh
	4UiRdkfEvXoxHU5sA=
X-Google-Smtp-Source: AGHT+IE6RbjtORaLIzRkhDeIZDE5ZvMexAyBHMwQbM1+M0jxjt/iljbOEs7nn/rbe5bTMSeXevSb7Q==
X-Received: by 2002:a05:6000:1882:b0:3a3:7387:3078 with SMTP id ffacd0b85a97d-3b5f2db1241mr11314884f8f.4.1752533848683;
        Mon, 14 Jul 2025 15:57:28 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45617f18d99sm52421885e9.8.2025.07.14.15.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 15:57:28 -0700 (PDT)
Date: Mon, 14 Jul 2025 23:57:26 +0100
From: Phillip Potter <phil@philpotter.co.uk>
To: Jens Axboe <axboe@kernel.dk>
Cc: Phillip Potter <phil@philpotter.co.uk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Christoph Hellwig <hch@infradead.org>,
	Chris Rankin <rankincj@gmail.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: cdrom: cdrom_mrw_exit() NULL ptr deref
Message-ID: <aHWLVhKKi0QAg9yM@equinox>
References: <uxgzea5ibqxygv3x7i4ojbpvcpv2wziorvb3ns5cdtyvobyn7h@y4g4l5ezv2ec>
 <aHF4GRvXhM6TnROz@equinox>
 <6686fe78-a050-4a1d-aa27-b7bf7ca6e912@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6686fe78-a050-4a1d-aa27-b7bf7ca6e912@kernel.dk>

On Mon, Jul 14, 2025 at 08:22:11AM -0600, Jens Axboe wrote:
> On 7/11/25 2:46 PM, Phillip Potter wrote:
> >> <1>[335443.339244] BUG: kernel NULL pointer dereference, address: 0000000000000010
> >> <1>[335443.339262] #PF: supervisor read access in kernel mode
> >> <1>[335443.339268] #PF: error_code(0x0000) - not-present page
> >> <6>[335443.339273] PGD 0 P4D 0
> >> <4>[335443.339279] Oops: 0000 [#1] PREEMPT SMP NOPTI
> >> <4>[335443.339287] CPU: 1 PID: 1988 Comm: cros-disks Not tainted 6.6.76-07501-gd42535a678fb #1 (HASH:7d84 1)
> >> <4>[335443.339301] RIP: 0010:blk_queue_enter+0x5a/0x250
> >> <4>[335443.339312] Code: 03 00 00 4c 8d 6d a8 eb 1c 4c 89 e7 4c 89 ee e8 8c 62 be ff 49 f7 86 88 00 00 00 02 00 00 00 0f 85 ce 01 00 00 e8 86 10 bd ff <49> 8b 07 a8 03 0f 85 85 01 00 00 65 48 ff 00 41 83 be 90 00 00 00
> >> <4>[335443.339318] RSP: 0018:ffff9be08ab03b00 EFLAGS: 00010202
> >> <4>[335443.339324] RAX: ffff8903aa366300 RBX: 0000000000000000 RCX: ffff9be08ab03cd0
> >> <4>[335443.339330] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> >> <4>[335443.339333] RBP: ffff9be08ab03b58 R08: 0000000000000002 R09: 0000000000001b58
> >> <4>[335443.339338] R10: ffffffff00000000 R11: ffffffffc0ccd030 R12: 0000000000000328
> >> <4>[335443.339344] R13: ffff9be08ab03b00 R14: 0000000000000000 R15: 0000000000000010
> >> <4>[335443.339348] FS: 00007d52be81e900(0000) GS:ffff8904b6040000(0000) knlGS:0000000000000000
> >> <4>[335443.339357] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> <4>[335443.339362] CR2: 0000000000000010 CR3: 0000000140ac6000 CR4: 0000000000350ee0
> >> <4>[335443.339367] Call Trace:
> >> <4>[335443.339372] <TASK>
> >> <4>[335443.339379] ? __die_body+0xae/0xb0
> >> <4>[335443.339389] ? page_fault_oops+0x381/0x3e0
> >> <4>[335443.339398] ? exc_page_fault+0x4f/0xa0
> >> <4>[335443.339404] ? asm_exc_page_fault+0x22/0x30
> >> <4>[335443.339416] ? sr_check_events+0x290/0x290 [sr_mod (HASH:ab3e 2)]
> >> <4>[335443.339432] ? blk_queue_enter+0x5a/0x250
> >> <4>[335443.339439] blk_mq_alloc_request+0x16a/0x220
> >> <4>[335443.339450] scsi_execute_cmd+0x65/0x240
> >> <4>[335443.339458] sr_do_ioctl+0xe3/0x210 [sr_mod (HASH:ab3e 2)]
> >> <4>[335443.339471] sr_packet+0x3d/0x50 [sr_mod (HASH:ab3e 2)]
> >> <4>[335443.339482] cdrom_mrw_exit+0xc1/0x240 [cdrom (HASH:9d9a 3)]
> >> <4>[335443.339497] sr_free_disk+0x45/0x60 [sr_mod (HASH:ab3e 2)]
> >> <4>[335443.339506] disk_release+0xc8/0xe0
> >> <4>[335443.339515] device_release+0x39/0x90
> >> <4>[335443.339523] kobject_release+0x49/0xb0
> >> <4>[335443.339533] bdev_release+0x19/0x30
> >> <4>[335443.339540] deactivate_locked_super+0x3b/0x100
> >> <4>[335443.339548] cleanup_mnt+0xaa/0x160
> >> <4>[335443.339557] task_work_run+0x6c/0xb0
> >> <4>[335443.339563] exit_to_user_mode_prepare+0x102/0x120
> >> <4>[335443.339571] syscall_exit_to_user_mode+0x1a/0x30
> >> <4>[335443.339577] do_syscall_64+0x7e/0xa0
> >> <4>[335443.339582] ? exit_to_user_mode_prepare+0x44/0x120
> >> <4>[335443.339588] entry_SYSCALL_64_after_hwframe+0x55/0xbf
> >> <4>[335443.339595] RIP: 0033:0x7d52bea41f07
> 
> This just looks totally broken, the cdrom layer trying to issue block
> layer commands at exit time. Perhaps something like the below (utterly
> untested) patch would be an improvement. Also gets rid of the silly
> ->exit() hook which exists just for mrw.
> 
> 
> diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
> index 21a10552da61..31ba1f8c1f78 100644
> --- a/drivers/cdrom/cdrom.c
> +++ b/drivers/cdrom/cdrom.c
> @@ -624,9 +624,6 @@ int register_cdrom(struct gendisk *disk, struct cdrom_device_info *cdi)
>  	if (check_media_type == 1)
>  		cdi->options |= (int) CDO_CHECK_TYPE;
>  
> -	if (CDROM_CAN(CDC_MRW_W))
> -		cdi->exit = cdrom_mrw_exit;
> -
>  	if (cdi->ops->read_cdda_bpc)
>  		cdi->cdda_method = CDDA_BPC_FULL;
>  	else
> @@ -651,9 +648,6 @@ void unregister_cdrom(struct cdrom_device_info *cdi)
>  	list_del(&cdi->list);
>  	mutex_unlock(&cdrom_mutex);
>  
> -	if (cdi->exit)
> -		cdi->exit(cdi);
> -
>  	cd_dbg(CD_REG_UNREG, "drive \"/dev/%s\" unregistered\n", cdi->name);
>  }
>  EXPORT_SYMBOL(unregister_cdrom);
> @@ -1264,6 +1258,8 @@ void cdrom_release(struct cdrom_device_info *cdi)
>  		cd_dbg(CD_CLOSE, "Use count for \"/dev/%s\" now zero\n",
>  		       cdi->name);
>  		cdrom_dvd_rw_close_write(cdi);
> +		if (CDROM_CAN(CDC_MRW_W))
> +			cdrom_mrw_exit(cdi);
>  
>  		if ((cdo->capability & CDC_LOCK) && !cdi->keeplocked) {
>  			cd_dbg(CD_CLOSE, "Unlocking door!\n");
> diff --git a/include/linux/cdrom.h b/include/linux/cdrom.h
> index fdfb61ccf55a..b907e6c2307d 100644
> --- a/include/linux/cdrom.h
> +++ b/include/linux/cdrom.h
> @@ -62,7 +62,6 @@ struct cdrom_device_info {
>  	__u8 last_sense;
>  	__u8 media_written;		/* dirty flag, DVD+RW bookkeeping */
>  	unsigned short mmc3_profile;	/* current MMC3 profile */
> -	int (*exit)(struct cdrom_device_info *);
>  	int mrw_mode_page;
>  	bool opened_for_data;
>  	__s64 last_media_change_ms;
> 
> -- 
> Jens Axboe

Happy to test. The patch makes a lot of sense. Will try and
recreate this as well - have just built 6.6 LTS and have it running in a
VM. Will report back. Many thanks.

Regards,
Phil
