Return-Path: <SRS0=UuDU=VA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEC7C5B57D
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 00:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8060B21E6C
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 00:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObfM7XHI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfGCA0q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Jul 2019 20:26:46 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40448 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfGCA0q (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Jul 2019 20:26:46 -0400
Received: by mail-oi1-f193.google.com with SMTP id w196so544583oie.7;
        Tue, 02 Jul 2019 17:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QHKCluGePZIU+McyVTxFHH0xCNV+DoEpqMdH3e/keAo=;
        b=ObfM7XHImA5a27zt4S10HFUJ96clje++hGYVuQoAy3Hjpnh6j1qvPypP3WUNf5sUZe
         SEL6s0+eviFcMAAHvCDg52Wrei5IfwJmtqa3+/Tp9tsPVdP6yGI3cOR+6i7pk4MDh6Pl
         E8i9pB8c24cYdb3Qyfj3kT9q54j5mnMlAl3OWrhU8EPft5OJYsWceT9dZt34cU2mOmJn
         geHMXLWL2I6x7TPjHxF4lzDQC7PNexP8Iaam6CbZZELKsEwlyyot1B3qNCKBAfc9+mfW
         txdvblUmxuYrpftaKb3QyAZ5OhZlifN3GNL2ZpImsd0/VF1LZhGPgyKcRL7mMnau0Zok
         HTZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QHKCluGePZIU+McyVTxFHH0xCNV+DoEpqMdH3e/keAo=;
        b=rLbudwB5pLGne9xnXx0n095SFlxbhkkOQ7Po/BiM7K6rBLlzT5Jjkv6RPEWWbYpQkv
         ekOzmxO66LqYDrVDvWdOyzqidMHx2V1x9E2KcwhTs9VN5+aKrnn+VB+9cOOk4X9INAvB
         sheyrTrIfQpwPbI3fJ6Wng1RLEmwbHXg4akTArC56r0LWNqO74AFEbrSIFpydAhagSKF
         pABVsEz6XU/5UhJQaqQu6HWNX0hlp56llCRoOdFxitGorxqnNmuPhOeLOqncTkU1UVzQ
         VprUl2E9iWy3Ko+UdvdG/dyua862STsHGHKbFsVWUHWhXvPytH6DatyLDQhXAaigpNor
         za7w==
X-Gm-Message-State: APjAAAXORDdPlqvXJMmedvYiiNFnm8d6vL0K9SGEV1wC5MqLMD7mnp05
        pNymMYadlS9l9ctmlI3KRhtAXuvaWhQ=
X-Google-Smtp-Source: APXvYqxyEm9SR/EPSZsblA25pKl2hkO2WC3ZeY2itLqHYCR9v9/JId7GV3e1Iud+xb8wF1vB7D38aw==
X-Received: by 2002:a65:404a:: with SMTP id h10mr34263500pgp.262.1562113240917;
        Tue, 02 Jul 2019 17:20:40 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id 12sm227706pfi.60.2019.07.02.17.20.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jul 2019 17:20:39 -0700 (PDT)
Date:   Wed, 3 Jul 2019 09:20:37 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, colyli@suse.de,
        linux-bcache@vger.kernel.org, linux-btrace@vger.kernel.org,
        xen-devel@lists.xenproject.org, kent.overstreet@gmail.com,
        yuchao0@huawei.com, jaegeuk@kernel.org, damien.lemoal@wdc.com,
        konrad.wilk@oracle.com, roger.pau@citrix.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH V3 2/9] blk-zoned: update blkdev_nr_zones() with helper
Message-ID: <20190703002037.GC15705@minwoo-desktop>
References: <20190702174236.3332-1-chaitanya.kulkarni@wdc.com>
 <20190702174236.3332-3-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190702174236.3332-3-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 19-07-02 10:42:28, Chaitanya Kulkarni wrote:
> This patch updates the blkdev_nr_zones() with newly introduced helper
> function to read the nr_sects from block device's hd_parts with the
> help if part_nr_sects_read().

It looks good to me.

Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>
