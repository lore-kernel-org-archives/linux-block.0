Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF3FC433F5
	for <linux-block@archiver.kernel.org>; Thu, 17 Feb 2022 02:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbiBQCjD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Feb 2022 21:39:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbiBQCjD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Feb 2022 21:39:03 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACECC4280
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 18:38:49 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id l8so3497187pls.7
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 18:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=GP9sAJcUZVBQR6DHM3orXruxIgyNQ5LCIF+Ef2yW8sQ=;
        b=Nm/HVZDNlYnysLnB0m6n4FD4t/UU3A1we6zmMN52fO/6vA1EMKvfAtvPIaPBPlI4pT
         h8vbs0zNKb0k/eB9soVgZvc344kzlHFqUekjxTNyrv2cGqgMMYhHHaqC61VdGfnsi+bU
         HCKFrPG7HA0lGIWYRdWMhzVZhFJtPNcKE3d9GSFgMnvBH5cD8XU3tZCjwj6/ZdxIax4V
         FmvqZX62unRxHppJP7BwpPGkAdG3Xhzjd5yUnboAKy8xRszJ36FDkNMeY1ufgg7orqy2
         tehe2ANqf9hZPbJvcUQBQyXxHnTOVC2coxIhsCVtn1H/OhIcbzUoBo3sA5g6GO4sKLyu
         n/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=GP9sAJcUZVBQR6DHM3orXruxIgyNQ5LCIF+Ef2yW8sQ=;
        b=g6JFBPwczgiJ54H0tY0VjvxonIQATkYTy2tduRnBkkTHsmt16U+xav21fb7hCa/9q5
         h+9AryyfEIdqVbjIW7v/aaDCHW78LjBUibkWnAihhZr/VWtv7MsIlxk98pANp6H/VdX+
         fldkSYGnHlbh9eRlZ2vySahysDdE0MUJjl0K8jIUXLh9JllWWHZHknAL1xnCe2EFYBoa
         /5viVVBqKJqrm8zCf8tL7WYgUSrAmvB007575FHQwd9mui2Pn402HNkFOtgzZd69y833
         LXVssg3H5bM2C/vShWw9+jlH5bTaAK7joERWT6SI+N6sbngQW6cvSLdnFE2YXM7225hB
         /L9g==
X-Gm-Message-State: AOAM530KdGvH5TDeozb2PfrkvzB7/717ACpO+INbX7jH91CtiuvddJZu
        DZ1BIZ6aPbAS1kLPMY4sl/HE2nAjRbKkBA==
X-Google-Smtp-Source: ABdhPJzRqEcGqtmy1i1/eCl4lM1MVKV3rNV1/+IRD6mspJJ3JDqBtAskKK6eO6dCp1mruv8oDXgZ6w==
X-Received: by 2002:a17:90a:67c7:b0:1b9:b5ed:3f19 with SMTP id g7-20020a17090a67c700b001b9b5ed3f19mr5043682pjm.90.1645065528954;
        Wed, 16 Feb 2022 18:38:48 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id h16sm16680608pfh.40.2022.02.16.18.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 18:38:48 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org
Cc:     damien.lemoal@wdc.com, shinichiro.kawasaki@wdc.com,
        ming.lei@redhat.com
In-Reply-To: <20220216172945.31124-1-kch@nvidia.com>
References: <20220216172945.31124-1-kch@nvidia.com>
Subject: Re: [PATCH V2 0/1] null_blk: cleanup null_submit_bio() & alloc_cmd()
Message-Id: <164506552788.45517.6348456698653419538.b4-ty@kernel.dk>
Date:   Wed, 16 Feb 2022 19:38:47 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 16 Feb 2022 09:29:44 -0800, Chaitanya Kulkarni wrote:
> This has alloc_cmd() cleanup that removes statically hardcoded function
> parameter and removes the need for the local variable on the stack.
> 
> Detailed test log is below that creates 5 memory backed nullb devices
> with queue_mode=0 (NULL_Q_BIO) and runs fio verify job, here is the
> summary:-
> 
> [...]

Applied, thanks!

[1/1] null_blk: remove hardcoded alloc_cmd() parameter
      commit: 55143a783f07e0914dd36b3f238fb1ede337e1f8

Best regards,
-- 
Jens Axboe


