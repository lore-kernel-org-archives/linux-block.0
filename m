Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097DD423151
	for <linux-block@vger.kernel.org>; Wed, 13 May 2026 12:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778676716; cv=none; b=Y0fAR+zUI9TsRhg2a7UkXGw8lckldq1+mCTSz669YS+3FAtPFrtPemyo5xmKldlYU8JfsuThAEtWpF+mM836Of6F1TvDsiyax5541IzLerwh21Xbkny7KRBEQf+tGccybBDahCXSTjAKZ5oOb4Po4j9203GaWGlUY+3fERvpM1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778676716; c=relaxed/simple;
	bh=q1ZzCv3qy931Od931muGLANVwooKhx0f1Vn6rfQqN0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qhzw8vHlTnODhZkKFLBmYvshhpwZfE46VQt9KIcZzCj0Ip8PNXvupFQq6F4yI6cmp27Fwn48YZzTMOeJu7fPy1EigG48N4w1Ulm9OGRjHzSMPIj12FNejs61JoUIA/nlgbRaVthFdtiuNTOMx6wkTwTNeD1I6QOiOHoOQAJL/24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7c58e6eb3edso18297527b3.2
        for <linux-block@vger.kernel.org>; Wed, 13 May 2026 05:51:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778676713; x=1779281513;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fmqp9pIMfFQVUOf0gODDSHc+R5Yka09MdAc/3G4zwFg=;
        b=YrNEWs+4fDHdSfF1jQO4Gu82m2UC/B2XfNwi57vyGDqBx6BwQdCsjM5PQm6LX1ES9f
         2ZBURMMSQllT6EjC+ApkitUgHZxSa+8HltjjEU1kVslCTp7N6LztFhHK6ZqMnfXqA4Xf
         A4v1S6MtOnBW7Mc0LV5R3vCNXA3ZLMXSfRdHCEqJCBFD/tQmIrqq7pOouKoc72qSmFaq
         lMSkSE4uUYDFFYaz3rPMIGeUw4k6xRdHIruPQ3Rpbk/ipjasR/+WlWJTxej9sf7NbAUE
         lDE79RhicUkpe0H/xWwdQMvKlc4JCtBdTJ5yKbdhUE8RrD2ISDlqKav7UIYyJAJNLAmA
         lgrg==
X-Gm-Message-State: AOJu0YwXsa7pmcTlSutrQGeBwQJdmXDpBb3LZgLHfhLSWSgnTM5R+BBM
	+BtUNBRAkr8+T+22wNfhoY2bdCbbM/cnQukevUGqZkuOzD5YEAGMSdAA
X-Gm-Gg: Acq92OGFATTMdPrlsA8HUZCiu6W7YAjhesa1Mj/HAo0UXweggjWpcW/qWDvXS/jZ684
	WraeA/zsRBCZU21woL/a/USmb39sg5G/QevKLrGzktKXww2c0PnltIaqcvjFhNzu2BN8ViB6C6q
	qeh831U0/PkSOowu8XXditVfKfia1lDRLCthvwBgshpGwPs4gpX3+d2psdmfZ/6GYGRh1gZzlg1
	pgsBlpC3w829IfvzXKj5YgCTPEwvslswWbrwZ2yqDBTv58iJb6ndEHbttWcXywhLMtYXz0Iw/i4
	47Wod05yOO4jOO32WfBmwVFSya4SABchGSWXTJ2dzdetUJPg310xG1Is8jlL9z/73/ujUBMOwhz
	nmwL6Y+K7LfbrhOSQdsbuf0Qjb+pEFKBrfewLUAEKp/W2h5EaZ5pvExEBblmZIZ/2iVlr8TA2JH
	pi/2/EpP/u4L/Q2JpbBY8tug1xFQHfRx8r92doVcEVSQd+sQMHO6WxJSZO/Bl28Ck=
X-Received: by 2002:a05:690c:7407:b0:7bd:5cc4:1962 with SMTP id 00721157ae682-7c6dd0af4e6mr22242187b3.48.1778676712899;
        Wed, 13 May 2026 05:51:52 -0700 (PDT)
Received: from [10.68.32.41] (bba-217-164-201-253.alshamil.net.ae. [217.164.201.253])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6686fbcdsm177353557b3.40.2026.05.13.05.51.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 05:51:52 -0700 (PDT)
Message-ID: <d9d586f3-c50c-4386-87ca-0d911c94d27c@linux.com>
Date: Wed, 13 May 2026 16:51:47 +0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: efremov@linux.com
Subject: Re: [PATCH] floppy: force media-change checks when clearing events
To: Cen Zhang <zzzccc427@gmail.com>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com
References: <20260506010248.3275696-1-zzzccc427@gmail.com>
Content-Language: en-US, ru-RU
From: "Denis Efremov (Oracle)" <efremov@linux.com>
In-Reply-To: <20260506010248.3275696-1-zzzccc427@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 06/05/2026 05:02, Cen Zhang wrote:
> floppy_open() tries to make blocking read/write opens perform a fresh
> media-change check by clearing drive_state[drive].last_checked before
> calling disk_check_media_change().  That timestamp is also updated by
> disk_change() when another FDC operation observes that the disk-change
> line is clear.
> 
> The worker path that calls disk_change() is not serialized by the
> floppy_mutex/open_lock pair held by floppy_open().  A worker can therefore
> store a recent jiffies value after floppy_open() stores zero and before the
> synchronous disk_check_media_change() call reaches floppy_check_events().
> The checkfreq throttle can then treat the media-change state as fresh and
> skip the hardware poll that the open path explicitly tried to force.

Thanks for the report and patch. The race you describe is real. However,
the proposed fix introduces a regression on the close path that I don't
think we can take as-is.

> 
> Use the block layer's clearing mask instead of a racy timestamp sentinel.
> When DISK_EVENT_MEDIA_CHANGE is being synchronously cleared, bypass the
> checkfreq throttle and poll the drive.  Periodic event checks still use
> last_checked to avoid unnecessary polling, and floppy_open() no longer
> needs to write last_checked itself.

bdev_release() unconditionally calls disk_flush_events(disk, DISK_EVENT_MEDIA_CHANGE);
on every final fput() of a block device. disk_flush_events() is not a no-op.
I'm afraid that after this patch every close of /dev/fd0 (or any floppy partition)
forces a synchronous FDC poll.

> 
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
> ---
>  drivers/block/floppy.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> index 92e446a643712..7217db0b907b3 100644
> --- a/drivers/block/floppy.c
> +++ b/drivers/block/floppy.c
> @@ -4051,7 +4051,6 @@ static int floppy_open(struct gendisk *disk, blk_mode_t mode)
>  		fdc_state[FDC(drive)].rawcmd = 2;
>  	if (!(mode & BLK_OPEN_NDELAY)) {
>  		if (mode & (BLK_OPEN_READ | BLK_OPEN_WRITE)) {
> -			drive_state[drive].last_checked = 0;
>  			clear_bit(FD_OPEN_SHOULD_FAIL_BIT,
>  				  &drive_state[drive].flags);
>  			if (disk_check_media_change(disk))
> @@ -4092,7 +4091,9 @@ static unsigned int floppy_check_events(struct gendisk *disk,
>  	    test_bit(FD_VERIFY_BIT, &drive_state[drive].flags))
>  		return DISK_EVENT_MEDIA_CHANGE;
>  
> -	if (time_after(jiffies, drive_state[drive].last_checked + drive_params[drive].checkfreq)) {
> +	if ((clearing & DISK_EVENT_MEDIA_CHANGE) ||
> +	    time_after(jiffies, drive_state[drive].last_checked +
> +			       drive_params[drive].checkfreq)) {
>  		if (lock_fdc(drive))
>  			return 0;
>  		poll_drive(false, 0);

For v2 I think we should avoid using the block-layer clearing mask as a force-poll
signal. We can make floppy_open() do the forced open-time poll directly under
lock_fdc(), then let disk_check_media_change() observe the resulting state.
This code pattern is already lives in FDPOLLDRVSTAT/FDFMTBEG handling branches.

Denis 
