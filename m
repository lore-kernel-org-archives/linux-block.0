Return-Path: <SRS0=wxXg=PM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CB0C43387
	for <linux-block@archiver.kernel.org>; Fri,  4 Jan 2019 16:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C70218D3
	for <linux-block@archiver.kernel.org>; Fri,  4 Jan 2019 16:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbfADQrA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Jan 2019 11:47:00 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37203 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfADQrA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Jan 2019 11:47:00 -0500
Received: by mail-pf1-f194.google.com with SMTP id y126so18553189pfb.4
        for <linux-block@vger.kernel.org>; Fri, 04 Jan 2019 08:47:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/gn1ZrALaeCR4Ie4VfKHyJj20bo2h89imp8HY7oVTPQ=;
        b=NVFQthT3Qm5CO05+TS/mKLzIW5Imh7ae7/VVsd4xjhncXHQc3MxX/bk2UKTUCZlXAq
         PR5BRi2Fi0O6oieZQqdOJP9csWqZg7f/e7fqj85Rpda7P5AuLeBzgNcinbJA1AG0W2NU
         LXmVFU1B8jkCKmQwwDC2lGZr+TYZaj8Zdugsbxcp9cSm92Fi5PqD/cCJBvo0U7zUsBCK
         lk4xSxuujdrKCRRt0iQPLuh4dd0tBEllKr24Zh668KTrznLP/4f3zwisvbXKvXeXhX4b
         hmYcfi4JzlgX4fZ3gsh03q/+uAShw3FkzjXmhiEVch86epIjMmWanjCn6U6s3KWiMApw
         W3RA==
X-Gm-Message-State: AA+aEWbLz+wnJPRjZzuJYlRLMyA4N0xgmqiuJB6wTQ4SHPJn25zUglkJ
        Udm5BiOxLlNkEgULEXye1mGBP2mJ0/aM/A==
X-Google-Smtp-Source: AFSGD/VRTsVYE3aYU3YDOCo4sGeQg53cv9nh8Dy5EQpzb9+lvIjrq1qpAGCxrDv/dp88LQ6/ZYOWBA==
X-Received: by 2002:a62:5a03:: with SMTP id o3mr52684871pfb.19.1546620419675;
        Fri, 04 Jan 2019 08:46:59 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id m9sm68307254pgd.32.2019.01.04.08.46.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 08:46:58 -0800 (PST)
Message-ID: <1546620417.163063.45.camel@acm.org>
Subject: Re: [PATCH] null_blk: add zoned config support information
From:   Bart Van Assche <bvanassche@acm.org>
To:     John Pittman <jpittman@redhat.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Date:   Fri, 04 Jan 2019 08:46:57 -0800
In-Reply-To: <20190104154243.3538-1-jpittman@redhat.com>
References: <20190104154243.3538-1-jpittman@redhat.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 2019-01-04 at 10:42 -0500, John Pittman wrote:
+AD4  static inline int null+AF8-zone+AF8-init(struct nullb+AF8-device +ACo-dev)
+AD4  +AHs
+AD4 +-	pr+AF8-info(+ACI-CONFIG+AF8-BLK+AF8-DEV+AF8-ZONED not enabled+AFw-n+ACI)+ADs
+AD4  	return -EINVAL+ADs
+AD4  +AH0

Have you considered to use pr+AF8-err() instead of pr+AF8-info()?

Thanks,

Bart.
