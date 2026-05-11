Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FECF383309
	for <linux-block@vger.kernel.org>; Mon, 11 May 2026 22:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778538017; cv=pass; b=TP7USbVm8P2df5MAh5V2AiBwZsrcQNPYb8K04wEQtfF6TD5oBosYhoesINXOIUxQfjb3TTZaj5wLOa+comSpTY+DiV/0bIVBK5BTJJU3yvMoyKa2fZnsjOh97kfV+Rt7SIBlmidWkOtMHSChjKD7ew5Xvbr2XwuPgSlqtuGaZ6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778538017; c=relaxed/simple;
	bh=dou4HRVPAokz68vS7kSm/IOslIhYWzXKbUnH3GFGjZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q+TTk2U7ONxefQ240ltD3eKjBfHH990K1t4l4a075b57qQeaIhmmd1837Qynjcy79ZVcWmfKm5ncvAzZIYhs+OjGyxgMnEfMV2tDAcIKsP6YCBsZW/ctDeGo3OGrvjgZdOsXdHqKzg39+4Gcg2D7JyR8a6Ml/IsSYfVb3qZgDiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H/UClv4A; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H/UClv4A"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1329fc4bf77so5573372c88.1
        for <linux-block@vger.kernel.org>; Mon, 11 May 2026 15:20:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778538015; cv=none;
        d=google.com; s=arc-20240605;
        b=Yl2IkpY2K7gsc9aKFKxcdviiv/PbQOYvA6v+SKiogK2GkYkyHgwc0VWojE8lAr1G8n
         +AZG22GZtEOJOEvSaFDOdiSlU5KlEHyIyYaX9ywTtsyUnqk9mi3D+1oGbLZ1QK0B+Tpi
         AQl034/7fMsAuAB0vCeGDR094KSpJmzYFTA1F5iX2z3ec+2pvRVH1nEXPMwhlI/h7AGO
         hbQ1MRZExkToNU3EGTTi2GL1nxQy6LenBUjty3ris9LdMaAecQuCiRO46F0VC3/u/U27
         lvdquGpGg3lpywvo+c5qSHrV7M023tcG8Z5PBUs2T0gPTzfnkh5jKqZtnIi5sD+N8pGS
         zuQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=U2jeNl3+Jjot1zOy9AtysSv4sNZeha9ms1/yevcKv3A=;
        fh=vdIHDuoR+DSmREEHj3jZh1uZkRajmarW6fk/Ji3qVXY=;
        b=GOsxg+CrO612oI08jsCexsfnYkAoirYWxVyiNNNnCo/KNeaPzSR9G+fc3CH5JuM8PF
         cjefnZx39kcJciRp2NlgoZ+jUdzqfad1leFjCTYx6VqsXF4soB7B09EoVtYWNyWv+cV9
         /bBG7+lGl7f7cQKHHbBHyP86UizHzGNRVsnOsCvz8vIe03Erb3Ivjsmuxh5vmxWUleP6
         f+wLTIvzl2wIBZ9miht+YtYK6cDwVAojzdN+CWBkceNM8Vd9S7N8MQTa71O7pjP6cq5u
         EwD3WwtVO2ZkD1e7AR6+uj77SPm9pQFgcqLGg9nN6L7aFQSHjZLa1qUTkWTHms4mxC3u
         Oo3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778538015; x=1779142815; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U2jeNl3+Jjot1zOy9AtysSv4sNZeha9ms1/yevcKv3A=;
        b=H/UClv4AFcmg4Ob0TAcCVJR8tqq3MoIkOJPmfU7ZgxX/xdJjsWbiFDs4SEvOEjGGmh
         WOwy43FWsrkkd896FOmnl/sKE4wxy+8ZkWfeZ1ME84xdkXo/XKpmgcHIibs0ioCejnk5
         8/6dp5ySs7p2r0d4h84lKz7lntkNhdocskao5SwjpdkqzYaQcftsXrXbzLAjvVo8tFy/
         TwKX0OXO04F5ud/Xj/unMpn0/XOJVlSgv4MOJ3K0Zb2HZaeaKKQYA1mpLz+jMlnVaUdS
         PfBx6twQeZO07+KvBY4eqjx5bwOByNwuwPGgOtDzY6080KJinYQaLwidcYLsV7aZX0L6
         9IAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778538015; x=1779142815;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U2jeNl3+Jjot1zOy9AtysSv4sNZeha9ms1/yevcKv3A=;
        b=iebU2Dzsx6vTMpH69TAqkQxzCzSKlEhTCA1dTy949wyaij9vlJ9XcrKV4mOLWxqefV
         T7wsC2CqC9XYNROQPhzkr/iGygKUIHPA1hKPz5LaM+TmNxubm90+cmbjNmH/SoIXug0N
         USt46Cltc40D73kDH8yYKc8eue/v2zWxcomTa85vRKUHeZ49qKCDkV881f56XR74M994
         OZNSfEBPR+RtXkPsIR2RM076T8F9w5Kx6TnXQNC5/omgvqdKXoWbFgsFkw2upDYXg+rW
         dUqAzFnF0loLWsGT5hWHqKqEaBv9q3ecgnAJfCP6LHDaz7iLsNBALDhyLJ4AAKGLWnVL
         gz1g==
X-Forwarded-Encrypted: i=1; AFNElJ8DYnDZ3VAAbs4aA9v++F/Tf00ZxIZjiin/wdtuTDvo6JCzRlillA1VEK2n+sCR+/5L7a5DoWpcbppoSA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIxNcKHadE670iEzgnbIpUWVPyDTyG8gmD7uzyb2zfIY4lhj2g
	msivPhM0l0HHMBuSRsN3fSdwzNbIW7OiwI7VSr41WzaxCEX+UGeruyVlYigk7ZHnuLnZl3izCJv
	V5EYU5ZdD2WJXc2veMKTGIzugIFRGNr5zV+SkRfDW
X-Gm-Gg: Acq92OHWL3P7D8ZAzhdxDbL2Qq6GMHqxYW1adb8uKifagbkTtPKFs3u5XxAtvTb47Nb
	ALy1fnTAMKd9RkQE5ybaPKi8ZbxE/2VYHFB/piV5Y5BZmu3DT0h9b57KsQQj+8R1oRJfrOihOYq
	qXaobuGtIwsFxxQlUewQ1ADWfURyq+Gz9LBs3F6Xl93v8YJt7kbfxZoxCxFV4TUAG9Tl3d5X8a+
	V1aiq/vQdUwSpd4LUxGlZuTAtpy9q5NVBp+U3+e7kaLpzh35+GRzxL+/3uBYkcIpiPSJijA0GyP
	AFgK61wN9EqXCU9aVgz+krfQdOg7C0QkU69h6B151mCtU3AlGznkwzmeMRGV
X-Received: by 2002:a05:7022:6707:b0:130:c9cc:33a1 with SMTP id
 a92af1059eb24-133450aa080mr358501c88.43.1778538014713; Mon, 11 May 2026
 15:20:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511163100.1887263-1-bvanassche@acm.org> <20260511163100.1887263-3-bvanassche@acm.org>
In-Reply-To: <20260511163100.1887263-3-bvanassche@acm.org>
From: Marco Elver <elver@google.com>
Date: Tue, 12 May 2026 00:19:38 +0200
X-Gm-Features: AVHnY4LwF9ePLVcGNfTsd1_fzyQGzfXyIvF7pkCaRrBTPxB2EvAI5Jrouk7d5h0
Message-ID: <CANpmjNNMDY=gB23ejdDYZg5yYduup_iXE1FAWC-fghr2od7Hwg@mail.gmail.com>
Subject: Re: [PATCH v4 02/12] block/bdev: Annotate the blk_holder_ops callback functions
To: Bart Van Assche <bvanassche@acm.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 May 2026 at 18:31, Bart Van Assche <bvanassche@acm.org> wrote:
>
> The four callback functions in blk_holder_ops all release the
> bd_holder_lock. Annotate these functions accordingly.
>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Because of this change we'll need clang 23, or you add:

CONTEXT_ANALYSIS := $(call clang-min-version, 230000)

.. although anything else that includes blkdev.h that has
CONTEXT_ANALYSIS := y, but is compiled with clang 22 will break.

Would have been good to wait for clang 23 to be released (August this
year) - although if we consider the next merge window + final release
of Linux 7.2, it might get reasonably close to August.


> ---
>  include/linux/blkdev.h | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 8651af4fe9d7..d0c181da2da0 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1747,22 +1747,26 @@ void blkdev_show(struct seq_file *seqf, off_t offset);
>  #endif
>
>  struct blk_holder_ops {
> -       void (*mark_dead)(struct block_device *bdev, bool surprise);
> +       void (*mark_dead)(struct block_device *bdev, bool surprise)
> +               __releases(&bdev->bd_holder_lock);
>
>         /*
>          * Sync the file system mounted on the block device.
>          */
> -       void (*sync)(struct block_device *bdev);
> +       void (*sync)(struct block_device *bdev)
> +               __releases(&bdev->bd_holder_lock);
>
>         /*
>          * Freeze the file system mounted on the block device.
>          */
> -       int (*freeze)(struct block_device *bdev);
> +       int (*freeze)(struct block_device *bdev)
> +               __releases(&bdev->bd_holder_lock);
>
>         /*
>          * Thaw the file system mounted on the block device.
>          */
> -       int (*thaw)(struct block_device *bdev);
> +       int (*thaw)(struct block_device *bdev)
> +               __releases(&bdev->bd_holder_lock);
>  };
>
>  /*
