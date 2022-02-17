Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B2AC433EF
	for <linux-block@archiver.kernel.org>; Thu, 17 Feb 2022 02:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbiBQCs0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Feb 2022 21:48:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbiBQCsZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Feb 2022 21:48:25 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334341FFCB5
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 18:48:12 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id m22so3789501pfk.6
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 18:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=z4i3sOJXuX5pLimLJFSpC+ldhVIHQTJAyQCIIZg6vB0=;
        b=MAKfpeBarFVBWwQcysBwZiWFmuKrF2I+yyKafwWHcLfuPTLpj5AhAFFMGSOS1ptpVW
         BYaxp5/QaxDBE1pbWlzrWulYvblHF3P7HnUm40geVqEe/CWtocilVYmWtBMQzvgh7gBP
         SbAi45TriQv1LDZ2FyoWNZKj3/g8YKlnllG9oTlhCX6attCGW/oTE70mpGrFw+Mm37eD
         LqBsarqyBz7pJPWcP7lS0PVSDwRX7c2kZZjb0yAi580ERYzK4vlWMpLyB6+sBS9G1+2S
         R+di0YkeuwdBoSGR3bQktJMmbNdIuykrRs4AADH7x+Gtr0RqPEq4USsFnolA7nsMWr9W
         XLrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=z4i3sOJXuX5pLimLJFSpC+ldhVIHQTJAyQCIIZg6vB0=;
        b=SVNMtHuixH9UryF703s0KAvgLvLZcqV5hCv+3iV99Zi7XMzlcMRuqJWBUP3TADUD9A
         T+dQflyCloS/s0KN0ZHtcJFTo6ZCEYlB1gGpJB6793ZvaEz5nf+1J/PZER8MCnQZm/tt
         Qoq8/2BH6BAfl4U9I5g0U8WjHG7Y6bLdg/9Zyh1EXn4aL7gPx4O3uDj71tKOy0qZmb9R
         iYI0OaWGEhf2pkWRB/0IehnXxeY6aEd50uqxJ3Hb46QTEOst0jlxPvN1KA/yt3ViLU3A
         PJk0dtmVmaTKe3A7kkjcxw4VAp5HVfCTuYAmLwEb+5mDf1t/JdaJlWpTB+hqdWpe/FfR
         sOFg==
X-Gm-Message-State: AOAM531RRp1/AU6hcRvs73+DvXZLQeUbiqU+QWbrDY3P1SuPWXOrSJ/B
        QHNXZUIUuazgIhDcGonTIt82tA==
X-Google-Smtp-Source: ABdhPJzvExI+t8yuXaS1DEStOCB4GW78Viv/TkR5lL+Qjf2kAF0uOwLJYp8MNv5DGGmehSRGmJjLtw==
X-Received: by 2002:a05:6a00:124a:b0:4e1:7cfb:634c with SMTP id u10-20020a056a00124a00b004e17cfb634cmr1100314pfi.12.1645066091528;
        Wed, 16 Feb 2022 18:48:11 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id lw3sm377109pjb.24.2022.02.16.18.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 18:48:11 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>, Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, linux-block@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        virtualization@lists.linux-foundation.org,
        linux-mmc@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220215094514.3828912-1-hch@lst.de>
References: <20220215094514.3828912-1-hch@lst.de>
Subject: Re: add a ->free_disk block_device_operation v3
Message-Id: <164506608998.50072.6316036301772123687.b4-ty@kernel.dk>
Date:   Wed, 16 Feb 2022 19:48:09 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 15 Feb 2022 10:45:09 +0100, Christoph Hellwig wrote:
> this series adds a ->free_disk method to struct block_device_operation so that
> drivers can defer freeing their disk private data until the gendisk goes away
> and don't need to play games with the validity of ->private_data.
> 
> This also converts three simple drivers over as example, but eventually I
> imagine that all drivers with private data will use it.
> 
> [...]

Applied, thanks!

[1/5] block: add a ->free_disk method
      commit: 76792055c4c8b2472ca1ae48e0ddaf8497529f08
[2/5] memstick/ms_block: simplify refcounting
      commit: e2efa0796607efe60c708271be483c3a2b0128de
[3/5] memstick/mspro_block: fix handling of read-only devices
      commit: 6dab421bfe06a59bf8f212a72e34673e8acf2018
[4/5] memstick/mspro_block: simplify refcounting
      commit: 185ed423d1898ead071c18f6161959cd3cab2dde
[5/5] virtio_blk: simplify refcounting
      commit: 24b45e6c25173abcf8d5e82285212b47f2b0f86b

Best regards,
-- 
Jens Axboe


