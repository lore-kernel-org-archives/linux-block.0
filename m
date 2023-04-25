Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7C1C77B61
	for <linux-block@archiver.kernel.org>; Tue, 25 Apr 2023 17:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbjDYRY7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Apr 2023 13:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234486AbjDYRY6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Apr 2023 13:24:58 -0400
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A371707
        for <linux-block@vger.kernel.org>; Tue, 25 Apr 2023 10:24:13 -0700 (PDT)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-5ef8af5d211so47292056d6.3
        for <linux-block@vger.kernel.org>; Tue, 25 Apr 2023 10:24:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682443452; x=1685035452;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aCEA6oTf8PBVVHa1nZnZS/PSju31UM4aZmgUr2cjHOk=;
        b=PElP3t4vSWgc6TZKFWVTiQ25d/H90K9BtBEKoOQdNySyFkOJWYYBQ33w8M58n8p6EO
         XcKv8JsFoA/VfNf+qFZVPqmyI5udLDrLnlknW80mRk+nJSgi6x27I3VFimwiGkrKIWTv
         EXfri1ozb9/8W3NU4R6TGsQ3BA3nJsmV9Dr1OsLh3Cq2THEM2JSWGgFIfT4MMCPPrv1c
         tXKNjvg+uieEQPtITGy7/+A2czLPeuoSVVG2JzP83d8v5VRjumNhvhawIG12d7l1oz0v
         ACMLXwwZb/Eiq9j6jgeAjdZBq8E7BxZYtiamfyP5yMLX8Nh1hL96olZULYvpPBxd8Q6R
         3aUg==
X-Gm-Message-State: AAQBX9f+D5ZzUgruKQg7TugW65Yofb3dpBLdzXiKk/qXryK3AgOkX1fi
        NShAY+24jw1fgw3bAj/jwZXE
X-Google-Smtp-Source: AKy350Yb0BPrIXqPDBPPuJ02a5Pv6Q0bGwEEX/y+TVfIyLzYnQz8w0X8y6f6KhPQMlj2FAY2nG+Kyw==
X-Received: by 2002:a05:6214:27c2:b0:5e9:2d8c:9a21 with SMTP id ge2-20020a05621427c200b005e92d8c9a21mr32113917qvb.32.1682443452154;
        Tue, 25 Apr 2023 10:24:12 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id h8-20020a0cfca8000000b005dd8b93459esm4209837qvq.54.2023.04.25.10.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 10:24:11 -0700 (PDT)
Date:   Tue, 25 Apr 2023 13:24:10 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, shinichiro.kawasaki@wdc.com,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "yangerkun@huawei.com" <yangerkun@huawei.com>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "yukuai (C)" <yukuai3@huawei.com>,
        Li Lingfeng <lilingfeng3@huawei.com>,
        Joe Thornber <ejt@redhat.com>
Subject: Re: [PATCH blktests] dm: add a regression test
Message-ID: <ZEgMuvNCud3fNdl4@redhat.com>
References: <20221230065424.19998-1-yukuai1@huaweicloud.com>
 <20230112010554.qmjuqtjoai3qqaj7@shindev>
 <6ccff2ec-b4bd-a1a6-5340-b9380adc1fff@huaweicloud.com>
 <oklvotdaxnncrugr2v7yqadzyfa5vvzrumrfv46vrzowjw3njo@tlvhd4eo5spl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <oklvotdaxnncrugr2v7yqadzyfa5vvzrumrfv46vrzowjw3njo@tlvhd4eo5spl>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 25 2023 at  8:15P -0400,
Shin'ichiro Kawasaki <shinichiro@fastmail.com> wrote:

> On Apr 25, 2023 / 16:22, Yu Kuai wrote:
> > Hi,
> > 
> > 在 2023/01/12 9:05, Shinichiro Kawasaki 写道:
> > > Hello Yu, thanks for the patch. I think it is good to have this test case to
> > > avoid repeating the same regression. Please find my comments in line.
> > > 
> > > CC+: Mike, dm-devel,
> > > 
> > > Mike, could you take a look in this new test case? It adds "dm" test group to
> > > blktests. If you have thoughts on how to add device-mapper related test cases
> > > to blktests, please share (Or we may be able to discuss later at LSF 2023).
> > 
> > Can we add "dm" test group to blktests? I'll send a new version if we
> > can.
> 
> I suggest to wait for LSF discussion in May, which could be a good chance to
> hear opinions of dm experts. I think your new test case is valuable, so IMO it
> should be added to the new "dm" group, or at least to the existing "block"
> group. Let's decide the target group after LSF.
> 

It's obviously fine to add a new "dm" test group to blktests.

But just so others are aware: more elaborate dm testing is currently
spread across multiple testsuites (e.g. lvm2, cryptsetup, mptest,
device-mapper-test-suite, etc).

There is new effort to port device-mapper-test-suite tests (which use
ruby) to a new python harness currently named "dmtest-python", Joe
Thornber is leading this effort (with the assistance of
ChatGPT.. apparently it has been wonderful in helping Joe glue python
code together to accomplish anything he's needed):
https://github.com/jthornber/dmtest-python

(we've discussed renaming "dmtest-python" to "dmtests")

I've also discussed with Joe the plan to wrap the other disparate
testsuites with DM coverage in terms of the new dmtest-python.
blktests can be made to be one of the testsuites we add support for
(so that all blktests run on various types of DM targets).

Really all we need is a means to:
1) list all tests in a testsuite
2) initiate running each test individually

Mike
