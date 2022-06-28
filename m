Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901A7C43334
	for <linux-block@archiver.kernel.org>; Tue, 28 Jun 2022 16:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbiF1QZA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jun 2022 12:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbiF1QYF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jun 2022 12:24:05 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C908B38D99
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 09:16:15 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id y14so20716038qvs.10
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 09:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fkrHLl+pC0T2wzEqJ1VmdS709M7bO1Mk3oguAYoCHsA=;
        b=S2uMzY1TZARDv/1VadP9BGX18k9XnXAyDTT4Nr2Cc+QyruRc//9e26bPFe+XIRu0Ng
         5peYAVYVSA4nTZoJBvAZE9Dj4kYoSgL1PKD+xUj/kFPxbGZoyrFn0Hd8qUehW1IK3RaL
         EHkMBe3MWOhxYKINOJTTcEnFn0SeFH4N4zs4QRuX6YG1Bat6B/ZYyDhB2ZTlWFTXeY58
         SJ2EnyKyI2/YrcgNCa8HXUd4vHC/pHyDcP72StAyKy2SsTYA9BbJ2v1KVhO0VuAP78A8
         XAnVfHXUP8kz8shyMwOHMf+KBx2HW5qHphrlXdrmutCI43Zg08vw9sk+jSWeCuOB6yL2
         vV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fkrHLl+pC0T2wzEqJ1VmdS709M7bO1Mk3oguAYoCHsA=;
        b=Ypj+BogKECVmTtsfJJH4ZLhuz4j0ay6H3uo7yFTa3VrtoGM4eXpCEFXjKS81oVrP4r
         gszuZiaMNG4XwJRH/wFCS/DMY/84JMfPTVnp/dnPg9+hgUZ+rh4Hqjpvsb4Qv8BHUBFG
         Y8/xGVz13MgKMa08qxcDb8KjzUexN7pLqzPZcaxnRrHsuqE3V9zysUV7mkhFmsI5WJP6
         xXIaZUrWGV/h2IaV9CW9Os6hEHnFIoRs4VObPJp9IHTmkW706vogu30pfbfnQFbdP/5A
         LbkGsdXN7ADYnbjRe9Ch8S0jwRdHAb2lPwQRxuaQvfFNQ4SEadN3vVMpeJyOnhsISkVi
         duNw==
X-Gm-Message-State: AJIora+s/G0AaYH+1xp3nSihUVE2wPcwSzHk09gOZsewKEgakArqPRdZ
        nvybX8AANfDCs2JMd9MwwA==
X-Google-Smtp-Source: AGRyM1sKkjEL7f9wSHLYpBtisYe/9DkZXLFCV6xhCzLO5Lsi0TS0+cJ3QYNT1nLShEcNWimNSwTK/w==
X-Received: by 2002:a05:622a:58d:b0:317:ca0d:91a5 with SMTP id c13-20020a05622a058d00b00317ca0d91a5mr13633763qtb.601.1656432974892;
        Tue, 28 Jun 2022 09:16:14 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id w11-20020a05622a190b00b003162a22f8f4sm4312465qtc.49.2022.06.28.09.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 09:16:13 -0700 (PDT)
Date:   Tue, 28 Jun 2022 12:16:12 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Eric Biggers <ebiggers@google.com>,
        Dmitry Monakhov <dmonakhov@openvz.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 5.20 1/4] block: add bio_rewind() API
Message-ID: <20220628161612.ajbyb723zx7w6b24@moria.home.lan>
References: <20220624141255.2461148-1-ming.lei@redhat.com>
 <20220624141255.2461148-2-ming.lei@redhat.com>
 <20220626201458.ytn4mrix2pobm2mb@moria.home.lan>
 <Yrld9rLPY6L3MhlZ@T590>
 <20220628042016.wd65amvhbjuduqou@moria.home.lan>
 <Yrqw/KY94DDtFVfl@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yrqw/KY94DDtFVfl@T590>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 28, 2022 at 03:42:52PM +0800, Ming Lei wrote:
> I don't see there is 'queue depth' for bio or bio driver.
> 
> 32 bytes have been big, and memory footprint is increased too since the data has been
> prepared for the future possible rewind. If crypt or integrity is considered, it
> can be bigger.

Put some thought into this, Ming. I think you've absorbed some "received
wisdom", some of the implicit assumptions everyone seems to be making without
ever doing any math to check if they make sense.

There may not be a "queue depth" for all drivers, but the same latency
considerations apply - if you have an unbounded number of IOs in flight, you're
going to be having other, much more significant issues.
