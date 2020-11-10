Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BB7C388F7
	for <linux-block@archiver.kernel.org>; Tue, 10 Nov 2020 19:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1884520781
	for <linux-block@archiver.kernel.org>; Tue, 10 Nov 2020 19:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="UP/1RwTZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730788AbgKJT4A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Nov 2020 14:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730618AbgKJT4A (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Nov 2020 14:56:00 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0304C0613D1
        for <linux-block@vger.kernel.org>; Tue, 10 Nov 2020 11:55:59 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id o20so14137081eds.3
        for <linux-block@vger.kernel.org>; Tue, 10 Nov 2020 11:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pgO8LSm7rMPKtTw+RAIb7HJGumePII/RfxxVSh9XMP0=;
        b=UP/1RwTZeKv+aSUgb1FlkZ5/PIjZxNgK+KEMRzbIkyBDPFpQKEhladO7Z9+0xT3Wa7
         mRMzvkmpmOiYEGuOR68MbAEBjN9zhiL6cJBz6PhTggHpyXLemfEcBVTaBwg8O76THgbp
         4QPzBn4mjcHju5puRuZo7S7RPhkP0Z2GbBx1lGC/CNi9voaw1uiukuYgLCMsLi8xp11i
         7pn9wI26agZFKqUM71DCJGysS8ZT8cttqI6SuwNNjMCxk1woEhQkBLXVeH69IugxHCUj
         axa+BCN/7tk4Slp/i9cQps+tmhdXQCW+IOXBlnaElCLlgQVDcqEFlzIFApLIfyC3LmrA
         ApGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pgO8LSm7rMPKtTw+RAIb7HJGumePII/RfxxVSh9XMP0=;
        b=PgH+oeWYO8ZnM1NwnvFP5nHZ2Wo/NgxpMt+3lV0ZpDaNrDk5nwmuzWSqvX/hFBJMNg
         xW0cQ/zgF4Kjp492sXNIzAaZuqb09nCBCE5NyCJgyN9MyM2WYG+qRq3nSkxooblmkNlu
         b74uTm6ULryhUQ0N62DlI+Ov5Zc8+rjKKuiOsP7ZHhNENzdh38QMvSuKYyR+2BLBE4mD
         56OIJywNPYOVNWCQDFKkVIcHO+tIqs6+dKZLYwAJIkiiqmJaDixjMg/fGcpA5a86oWUt
         Qp7wxSDcJJORwwqupOuh6UPauKTFIudLDoDuF4u6L7Ym6ON/M6QBNIDTQ2UC69c0xLmq
         6uJw==
X-Gm-Message-State: AOAM530Htr2p6YdjiqwdrWGXltDIWJX39OHDQcJl6Yc+YdK0wmJWYQrs
        OlGx++1xSVrj8PrS5zYJO/xefg==
X-Google-Smtp-Source: ABdhPJx0eHHki8+yi032+9uSCy/U1eYvA3pLpI8aZqWtK8JaOiCdpynRyj2vbX/T7T9JWkc7B8NqsA==
X-Received: by 2002:aa7:d64b:: with SMTP id v11mr1106671edr.253.1605038158720;
        Tue, 10 Nov 2020 11:55:58 -0800 (PST)
Received: from localhost (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
        by smtp.gmail.com with ESMTPSA id d19sm11103156eds.31.2020.11.10.11.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 11:55:58 -0800 (PST)
Date:   Tue, 10 Nov 2020 20:55:57 +0100
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        "k.jensen@samsung.com" <k.jensen@samsung.com>
Subject: Re: nvme: enable ro namespace for ZNS without append
Message-ID: <20201110195557.v25tq7eicxzwfgrz@MacBook-Pro.localdomain>
References: <20201110093938.25386-1-javier.gonz@samsung.com>
 <20201110094354.GB25672@lst.de>
 <20201110112554.GA465503@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201110112554.GA465503@localhost.localdomain>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10.11.2020 11:25, Niklas Cassel wrote:
>On Tue, Nov 10, 2020 at 10:43:54AM +0100, Christoph Hellwig wrote:
>> > -	if (id->nsattr & NVME_NS_ATTR_RO)
>> > +	if (id->nsattr & NVME_NS_ATTR_RO ||
>> > +			test_bit(NVME_NS_FORCE_RO, &ns->flags))
>
>Indentation for the test_bit() looks off.
>I assume that Christoph can fixup that when applying.
>
>$ ./scripts/checkpatch.pl --strict ~/javier.patch
>CHECK: Alignment should match open parenthesis
>#280: FILE: drivers/nvme/host/core.c:2062:
>+       if (id->nsattr & NVME_NS_ATTR_RO ||
>+                       test_bit(NVME_NS_FORCE_RO, &ns->flags))
>
>
>For the record:
>
>WARNING: From:/Signed-off-by: email address mismatch: 'From: "Javier González" <javier@javigon.com>' != 'Signed-off-by: Javier González <javier.gonz@samsung.com>'
>
>If you want to use a SoB that is different from the email address which
>you are sending from, then according to the The canonical patch format:
>
>https://www.kernel.org/doc/html/latest/process/submitting-patches.html#the-canonical-patch-format
>
>"""
>The from line must be the very first line in the message body, and has the form:
>
>    From: Patch Author <author@example.com>
>
>The from line specifies who will be credited as the author of the patch in the permanent changelog.
>If the from line is missing, then the From: line from the email header will be used to determine
>the patch author in the changelog.
>
>Note, the From: tag is optional when the From: author is also the person (and email) listed in the
>From: line of the email header.
>"""
>
>
>That way, when the maintainers use git am, it will pick the author
>from the "From:" in the message body, rather than from the email header.
>
>Otherwise the Author: field in the git log will be different from your SoB.
>
>There are several ways you can fix this, either by using the correct email
>when you do the commit in the first place, then git format-patch will add
>From: automatically, or by using the git config sendemail.from, or --from
>option to git-send-email.
>

Thanks for taking the time Niklas. I have done this intentionally for
quite some time - I use javier@javigon.com to submit and commit and then
sign-off with my current employer.

If this presents an inconvenience, I don't mind changing the committer
to my current Samsung email.
