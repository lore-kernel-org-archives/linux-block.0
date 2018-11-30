Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5B7C04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 17:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 847592145D
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 17:30:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 847592145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbeLAEk7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:40:59 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44292 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbeLAEk6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 23:40:58 -0500
Received: by mail-pl1-f194.google.com with SMTP id k8so3118754pls.11
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 09:30:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f64crJ4+2pevNi4NHlNdPbhh80MEMyJXoOSIIz/8kJQ=;
        b=hJuFxjCEXJI4UFyAhLE80OrpxbpcoihQwSvIArizV7qR0tAsmU2vZouCxM20qYcNeM
         2z/6khJjrZs6ISacHxUvIJi07W5Z2kRkL4RZaAoGN3IllXP5Avksl4Q3RBpAEirrUjg4
         b6qQMmnF63eQjuQCkCyfoDJiDqMzXv23U7TVFbh8EhYNd9Jboc0kiI6fpB1p/uFpeihs
         AWVBnirYu8MHT0n4qlAbdp5nPv59OGPE819ACQ2qDPnLe8XQANu898bf3/1qwjcCC2w/
         QbMM6gA8meTd+PoiRH76CKVMXV+j343gn4pSG06O/LPrKbXpf0VmUItypWXYMaIoPfN+
         AacQ==
X-Gm-Message-State: AA+aEWbKP8Gqf9IvHwmo/oHn5i70blAaVs6jHaM7AHhYhoD6G/KYm2yW
        FzNFkuOvxSR+kVT1pfrtDIQ8dELV
X-Google-Smtp-Source: AFSGD/X0sTC6itk7keGsKGaE/ehdlibIywz5SQkW3/kzKrWqSsZTcO0yVYUEGolSt1AKVdQGKy44BQ==
X-Received: by 2002:a17:902:2c03:: with SMTP id m3mr6216767plb.6.1543599058074;
        Fri, 30 Nov 2018 09:30:58 -0800 (PST)
Received: from ?IPv6:2620:15c:2c0:5:2d74:bb8d:dd9b:a53e? ([2620:15c:2c0:5:2d74:bb8d:dd9b:a53e])
        by smtp.gmail.com with ESMTPSA id o66sm18723387pgo.75.2018.11.30.09.30.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 09:30:57 -0800 (PST)
Message-ID: <1543599056.4347.11.camel@acm.org>
Subject: Re: [PATCH] block: fix single range discard merge
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-block@vger.kernel.org, Guangwu Zhang <guazhang@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Jianchao Wang <jianchao.w.wang@oracle.com>
Date:   Fri, 30 Nov 2018 09:30:56 -0800
In-Reply-To: <9ebec24a-103c-2ea8-49e1-2f927eb8a4f8@kernel.dk>
References: <20181130163818.6540-1-ming.lei@redhat.com>
         <1543598309.4347.5.camel@acm.org>
         <9ebec24a-103c-2ea8-49e1-2f927eb8a4f8@kernel.dk>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 2018-11-30 at 10:20 -0700, Jens Axboe wrote:
+AD4 On 11/30/18 10:18 AM, Bart Van Assche wrote:
+AD4 +AD4 On Sat, 2018-12-01 at 00:38 +-0800, Ming Lei wrote:
+AD4 +AD4 +AD4 Fixes: 445251d0f4d329a (+ACI-blk-mq: fix discard merge with scheduler attached+ACI)
+AD4 +AD4 
+AD4 +AD4 Since this patch fixes a bug introduced in kernel v4.16, does it need
+AD4 +AD4 a +ACI-Cc: stable+ACI tag?
+AD4 
+AD4 Like the other one, isn't stable implied with Fixes in there? You'd want
+AD4 a stable backport for any kernel that has that patchset. I think that's
+AD4 a stronger hint than stable cc.

(+-Greg KH)

Hi Greg,

Would it be possible to clarify what your preferences are for adding a
+ACI-Cc: stable+ACI tag?

Thanks,

Bart.
