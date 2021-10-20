Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29ECC433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 14:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB98461374
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 14:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhJTOOu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 10:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhJTOOt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 10:14:49 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C69C06161C
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 07:12:35 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id d21-20020a9d4f15000000b0054e677e0ac5so6603395otl.11
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 07:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W3Q7Dh2ujhBL/b6CJ/27uuMJlO13X6l3lEzVOHSlgG0=;
        b=VMBSL2pcy4eNLKVRzo8SZ2slo+0qPeMJ0VSH8Jo1ncv0DMmzzNzijm5jWnTRGa3B/J
         Khb9Ga7Tb5oxMX8q39RLjM3zNTkbZOjuOCSGILmrEtLsc1UPQuTvKzDlI22TB+ek9pYB
         FXqmULy/jhBQ6S16UrveRbSbn2vIJVLn9hUGBi95tzOUODZ5zo+AXSgIlwrciCxO4nX0
         d6CoOZJ/tOsow+JPIRVhZI1jnOPZbEBu8DVCxwpvj2Obba6nh9clToWNkfTqLc9vWtsE
         qYKTLaPRMRS18jVyNRLpt6vbbrvtJdimBXZ+onNpX82L5nWS499+Wqcz1mifRzqn9DUh
         Z1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W3Q7Dh2ujhBL/b6CJ/27uuMJlO13X6l3lEzVOHSlgG0=;
        b=B4H6gW7PKH17+omHdmhQNVNu3f1pou2UmMHo31LpfMgHVHhAL6Ve4Y7GkVkVh7tlzi
         DP8ile08mWuHiC1wkH2gLFkrvIWaklcheg4W9IUjLFCFMDo50ehXNIT/6/9ap7OTVoxA
         KcWsO5Ahz4erE26Iiz9e6AFxAomnrocZk0sWVAumPXzGsaAyjKlH67jEueNgn29f2xdd
         BK13lNiOn0mQ4nuEekjZGHfW0ipFxxp0RNFayFJZRFXkUKkcN34GVL2w2t9GL2XLxypQ
         ZZOZnwqiGRpX0DwMVROHbM9W8GfEfayZEp2jB9vaWr5gm0ufdTcTWph/rpPai8t2Jmsu
         nXRA==
X-Gm-Message-State: AOAM5315jaYnY4u7KVs5MTcxZbngz3KCqQYHLzaI6qHiKrZD4bBUCBHh
        scgj8bH7sAECVwFD7mERSWcWKow4T3AMwg==
X-Google-Smtp-Source: ABdhPJzJzK1kYnSmR4+AuJgK52IZNF01Cnf9iDmFns3sNSEW+EfbR4HJGdLZw1xJz85z05QJERC0NA==
X-Received: by 2002:a9d:6c16:: with SMTP id f22mr95836otq.364.1634739154418;
        Wed, 20 Oct 2021 07:12:34 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id h91sm475412otb.38.2021.10.20.07.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 07:12:34 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: Re: (subset) [PATCH 00/16] block optimisation round
Date:   Wed, 20 Oct 2021 08:12:30 -0600
Message-Id: <163473913694.734248.7272076627568407137.b4-ty@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1634676157.git.asml.silence@gmail.com>
References: <cover.1634676157.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 19 Oct 2021 22:24:09 +0100, Pavel Begunkov wrote:
> Jens tried out a similar series with some not yet sent additions:
> 8.2-8.3 MIOPS -> ~9 MIOPS, or 8-10%.
> 
> 12/16 is bulky, but it nicely drives the numbers. Moreover, with
> it we can rid of some not used anymore optimisations in
> __blkdev_direct_IO() because it awlays serve multiple bios.
> E.g. no need in conditional referencing with DIO_MULTI_BIO,
> and _probably_ can be converted to chained bio.
> 
> [...]

Applied, thanks!

[01/16] block: turn macro helpers into inline functions
        (no commit info)
[02/16] block: convert leftovers to bdev_get_queue
        (no commit info)
[03/16] block: optimise req_bio_endio()
        (no commit info)
[04/16] block: don't bloat enter_queue with percpu_ref
        (no commit info)
[05/16] block: inline a part of bio_release_pages()
        (no commit info)

Best regards,
-- 
Jens Axboe


