Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAE3C04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 17:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED2520834
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 17:19:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EED2520834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbeLAE2b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:28:31 -0500
Received: from mail-pl1-f180.google.com ([209.85.214.180]:34489 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbeLAE2a (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 23:28:30 -0500
Received: by mail-pl1-f180.google.com with SMTP id w4so3126349plz.1
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 09:18:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ge2osPvKZuovNxfz2f5vKP9lwuZnGfaRSKI8fIpEIxw=;
        b=ROvhiaO+4veYlv6C9sC1wuHhRCreaFNzhmL3DC3SWxq9RoAy7jXF2Oqd/0WTYZ1lsF
         Dx7XgVS0ogK2YS/+oh3ogd+GI9FEWiaBrDmjVzw3dKPCcWyQIwJyOTxYMV+CBxPJTq6o
         c2LTWtuE4L5fKTiojUbpeFTaldDs5mKG/r1Yazxa2fi7L6An+J1OeBb9NGQQWeJqIZG+
         o9aUyx/QpHb6hG6gdnQFnpeFsFJMdB85hDSI5etBGX7dbaOeFkrp9zHCU05ZAluppygE
         hcXNCc2KvwXB4JRFb8yfQS4DwLcxNF6AhGfH6qlqg1qRNXCYD8vSjwfn6AGiIzV6gLIU
         SGhQ==
X-Gm-Message-State: AA+aEWZIOG2MK1vSLecw3g1SZaye8VtxDaACuI1XNXVejQtZFLmLjA0B
        EyPb8+H71x30lJJ8fDDaYa8=
X-Google-Smtp-Source: AFSGD/Xo6OvAmpo30vT2GrdRn7OfgC5Me8el01snIgl4uFjBsnNJo/4SMdSv3G1FVWfBjynxEdyFZA==
X-Received: by 2002:a17:902:4025:: with SMTP id b34mr6532241pld.181.1543598311620;
        Fri, 30 Nov 2018 09:18:31 -0800 (PST)
Received: from ?IPv6:2620:15c:2c0:5:2d74:bb8d:dd9b:a53e? ([2620:15c:2c0:5:2d74:bb8d:dd9b:a53e])
        by smtp.gmail.com with ESMTPSA id x12sm6354181pgr.55.2018.11.30.09.18.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 09:18:30 -0800 (PST)
Message-ID: <1543598309.4347.5.camel@acm.org>
Subject: Re: [PATCH] block: fix single range discard merge
From:   Bart Van Assche <bvanassche@acm.org>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Guangwu Zhang <guazhang@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Jianchao Wang <jianchao.w.wang@oracle.com>
Date:   Fri, 30 Nov 2018 09:18:29 -0800
In-Reply-To: <20181130163818.6540-1-ming.lei@redhat.com>
References: <20181130163818.6540-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, 2018-12-01 at 00:38 +-0800, Ming Lei wrote:
+AD4 Fixes: 445251d0f4d329a (+ACI-blk-mq: fix discard merge with scheduler attached+ACI)

Since this patch fixes a bug introduced in kernel v4.16, does it need
a +ACI-Cc: stable+ACI tag?

Thanks,

Bart.
