Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39022C77B75
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 17:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238069AbjEWROL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 13:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238049AbjEWROG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 13:14:06 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076CF18F
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 10:14:01 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-339fca7da2aso760765ab.0
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 10:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1684862041; x=1687454041;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmWtJOzNztkpnf4UzHCczQhsDx+hgxiMe2XgRqYyHhI=;
        b=rQvy6TSK+wfTlo0HdARvbSVdkvmZoky53LQfz6I/sHZSh/vam08zvcWX8BKFq35rPJ
         FiOXal8syvG9pEP0WTv6iW7eSanhHy7ABqS8itvydZ8rH14nwiDgZz79SGNg3RH3bQj8
         WTmLv9HJ2uOAsK7i88YATrsiJwt/hKCRYYVxQMA7/a3MuM4g4yafCnt36kQlOjL/VWPH
         6o5dMj0POMwamomezMYNOxNy841T05ufNRwMDpAkAYeEwREsLkqobJ+hg8+fwPBm4nOe
         u6quTE5qyRblQsMAa260HpGZ0iO2Y0Wue1iugiodj3bo6gNKl8rdK5sY8KOYxSKugSqK
         REMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684862041; x=1687454041;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qmWtJOzNztkpnf4UzHCczQhsDx+hgxiMe2XgRqYyHhI=;
        b=NgBLahgrmDw+Jnl3ufpi9Eqx50suLPaDlNXiucGY6LqUZ7ZgJLgvIWbBmnii4OhKUd
         0bDO4Q8vKlbqCFpMDAk1yNtBrwPo77ZLIJ/D2VSbOb4w7f9bxaO6F1/7eucVXMyQMwL4
         oDWSk9zlA7Kuad0DNBoJRslXIjLPUtGmeriA7475WTOBQqj7OeFvE7E5RXG2vbpZdMCD
         Wg6ZVsBNoiJbHZfwqHGi9H9h95a+lCACgzMwehNLojg0nYtmAB9qYOsQPFmbeOnx1jAd
         tha48RlN6Tea/ltHdUh1XgsgXrPOR4TXSmqXUTWbRf6fkLjWCClq10Yy7VXn5dxuD8lz
         GmlQ==
X-Gm-Message-State: AC+VfDyHY3ESQhUAOfa8ge3f2YLBkzb2E7UlDYxxYSWCGiVDHNW9HLI0
        UZwRsd9DlceEJ+hiLztIJE+1EA==
X-Google-Smtp-Source: ACHHUZ484Klt0h0DdDR9++SF2ilwYFPu1B4JHU4ETiLnEdiOPsAptOMMT7O5wPaxS3A/GWCCiNI72w==
X-Received: by 2002:a6b:b70c:0:b0:774:80fc:11a9 with SMTP id h12-20020a6bb70c000000b0077480fc11a9mr1794870iof.1.1684862041070;
        Tue, 23 May 2023 10:14:01 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id u7-20020a02aa87000000b00411a1373aa5sm2524580jai.155.2023.05.23.10.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 10:14:00 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     tj@kernel.org, hch@lst.de, josef@toxicpanda.com,
        Yu Kuai <yukuai1@huaweicloud.com>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
In-Reply-To: <20230414084008.2085155-1-yukuai1@huaweicloud.com>
References: <20230414084008.2085155-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH for-6.4/block] block/rq_qos: protect rq_qos apis with a
 new lock
Message-Id: <168486203985.398377.17593981162726402548.b4-ty@kernel.dk>
Date:   Tue, 23 May 2023 11:13:59 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Fri, 14 Apr 2023 16:40:08 +0800, Yu Kuai wrote:
> commit 50e34d78815e ("block: disable the elevator int del_gendisk")
> move rq_qos_exit() from disk_release() to del_gendisk(), this will
> introduce some problems:
> 
> 1) If rq_qos_add() is triggered by enabling iocost/iolatency through
>    cgroupfs, then it can concurrent with del_gendisk(), it's not safe to
>    write 'q->rq_qos' concurrently.
> 
> [...]

Applied, thanks!

[1/1] block/rq_qos: protect rq_qos apis with a new lock
      commit: a13bd91be22318768d55470cbc0b0f4488ef9edf

Best regards,
-- 
Jens Axboe



