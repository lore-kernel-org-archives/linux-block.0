Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCC2C19F2A
	for <linux-block@archiver.kernel.org>; Sun,  7 Aug 2022 18:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234542AbiHGSS0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 7 Aug 2022 14:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232183AbiHGSSZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 7 Aug 2022 14:18:25 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57BE6474
        for <linux-block@vger.kernel.org>; Sun,  7 Aug 2022 11:18:23 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220807181821epoutp01be9cd8593a844385793f52db332b29c8~JIuRd6jvP1266712667epoutp01h
        for <linux-block@vger.kernel.org>; Sun,  7 Aug 2022 18:18:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220807181821epoutp01be9cd8593a844385793f52db332b29c8~JIuRd6jvP1266712667epoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659896301;
        bh=O+UFO5qYOJ3u3N26CK241oZzh2I3TrMTIwrq+OHFyt4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SFo8C6PTEUvjqvFDa4t2mAoTC2jcvBUlJYbdG3Qey/fayXM0+DLWiYibcwRZ5Ueij
         jcIZ/1NFG6bGP8wLyzW+fr2h7KHIeYUenfoHfR5s7GsLpiVvkMS1X11eaOYLDX19VM
         yUcrbz6NBDN9+V65JFIc1kl5uJiE8AC8AJM6fMlU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220807181821epcas5p1ca23dc74e9c9cedd0956e1be139f2635~JIuQ9mDZy2288222882epcas5p1n;
        Sun,  7 Aug 2022 18:18:21 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4M16yg18rNz4x9Pt; Sun,  7 Aug
        2022 18:18:19 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6F.91.42669.BE100F26; Mon,  8 Aug 2022 03:18:19 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220807181817epcas5p4998894c3f2317fd7d8c20265fd7ae8fc~JIuN0Fa8T1423614236epcas5p4Z;
        Sun,  7 Aug 2022 18:18:17 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220807181817epsmtrp10c8a02edbfd9d2558470eeaa00e1d67e~JIuNzd6Iw2191021910epsmtrp1V;
        Sun,  7 Aug 2022 18:18:17 +0000 (GMT)
X-AuditID: b6c32a4a-b3bff7000001a6ad-95-62f001eb5fed
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        87.49.08802.9E100F26; Mon,  8 Aug 2022 03:18:17 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220807181817epsmtip20bf1f6a8b0623c4da612340c28b24635~JIuNKP7P10243902439epsmtip2H;
        Sun,  7 Aug 2022 18:18:17 +0000 (GMT)
Date:   Sun, 7 Aug 2022 23:38:55 +0530
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, kbusch@kernel.org
Subject: Re: [PATCH 2/3] block: enable bio caching use for passthru IO
Message-ID: <20220807180855.GA30655@test-zns>
MIME-Version: 1.0
In-Reply-To: <20220806152004.382170-3-axboe@kernel.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDKsWRmVeSWpSXmKPExsWy7bCmlu5rxg9JBgfPsFmsvtvPZjHp0DVG
        i723tB2YPS6fLfXYtKqTzePzJrkA5qhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNL
        C3MlhbzE3FRbJRefAF23zBygNUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScApMC
        veLE3OLSvHS9vNQSK0MDAyNToMKE7IzfG5vZC16wVbz+fJ2pgfEuaxcjJ4eEgInExgWzgGwu
        DiGB3YwSV55PYgJJCAl8YpT4sT0VIvGZUeLP1+mMMB13FzxlgSjaxShxaWoURNEzRomJs/rA
        EiwCKhIPu+8CTeLgYBPQlLgwuRQkLCKgINHzeyUbiM0sYCTx4GML2DJhATeJt78WgV3EK6Ar
        0Xd5KzOELShxcuYTFpAxnAJmEpPW24OERQWUJQ5sO84EslZC4By7xJ3X06Buc5FYPu8WC4Qt
        LPHq+BZ2CFtK4mV/G5SdLHFp5jkmCLtE4vGeg1C2vUTrqX5miNsyJDbPn84EYfNJ9P5+AvaK
        hACvREebEES5osS9SU+hgSgu8XDGEijbQ6LvzE12SJBsZZRY3jSBbQKj3Cwk78xCsgLCtpLo
        /NDEOgtoBbOAtMTyfxwQpqbE+l36CxhZVzFKphYU56anFpsWGOWllsNjODk/dxMjONlpee1g
        fPjgg94hRiYOxkOMEhzMSiK8R9a+TxLiTUmsrEotyo8vKs1JLT7EaAqMnYnMUqLJ+cB0m1cS
        b2hiaWBiZmZmYmlsZqgkzut1dVOSkEB6YklqdmpqQWoRTB8TB6dUAxPTNp93/5aJ5TVZbkw7
        e/nqjX87d2xJdnirvNH13ueS1taAS7YHxCQUtK/YrOF189ZrLbQwKuz5uf/w2/N19XIZ3TJ6
        lv+yxY5pbkuTV3pZeffl+ySdU8czTZ4sXBL0demC2bXl/wxsUrxmn5z5wu3Ye447+ewfr2RI
        Lz/Rp9NpsbrJ+b2i8obVB94zLFpmwLBhRfzcE0aJvE/u/rGqVU4yqdi2TP3QVsWL8894uaVG
        xd0vf54bYbaRfbt1XseDpdN/rBJ4+urdQZb329sU/jG8nnxtEeM8TluPY68PPuK57deWauj8
        y/niW0W7vjDutRFhM7auW+dqo+x0O+q++b3ULmdr+wUsC4uOqpRfiWNTYinOSDTUYi4qTgQA
        AiYynP8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsWy7bCSvO5Lxg9JBr+/GlqsvtvPZjHp0DVG
        i723tB2YPS6fLfXYtKqTzePzJrkA5igum5TUnMyy1CJ9uwSujA2vjrMXzGKpOHbiGVsD40rm
        LkZODgkBE4m7C56ygNhCAjsYJd61xUPExSWar/1gh7CFJVb+ew5kcwHVPGGUmP9gMitIgkVA
        ReJh912mLkYODjYBTYkLk0tBwiICChI9v1eygdjMAkYSDz62MIHYwgJuEm9/LQJr5RXQlei7
        vJUZYuZWRokF17qYIBKCEidnPmGBaDaTmLf5ITPIfGYBaYnl/zhATE6g8KT19iAVogLKEge2
        HWeawCg4C0nzLCTNsxCaFzAyr2KUTC0ozk3PLTYsMMpLLdcrTswtLs1L10vOz93ECA5fLa0d
        jHtWfdA7xMjEwXiIUYKDWUmE98ja90lCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeS90nYwXEkhP
        LEnNTk0tSC2CyTJxcEo1MK12zG+uehDrqzCb/6e4blPizNrJkbkKKhznlqf89ZsYVs23b528
        5ZTL8g2ft0WIrzyfwphnOrM6TknJ6HxA7sZ1Bev9JyqHZem/O5ax/UnoNfaoeZcd1Tj/ZXNp
        tG+Vy+Ju31D87GakhAzjmtWmM1+sn7f22f0rzV7PeLqbLnDeOP89y71bTiq8+c0/reptHy5Z
        S8z8I8wo92iW/JHpaflXl73Qm25sfyN5XvCGU6kMl5zCJ+19ri3xx/XsxUkzKpfJS0xR3XX4
        OEOuzkdem4i2nrXz7n7wd2IIazu/LUE7fI7TX0HhG5+Zy3f3GnE0/5s018kzyP7lYZGP70Tz
        NsYenXh4zcr05JBLn2yzliuxFGckGmoxFxUnAgAYPLVDzgIAAA==
X-CMS-MailID: 20220807181817epcas5p4998894c3f2317fd7d8c20265fd7ae8fc
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----W1bEPTvsorsTcy9-0QGogbD0KLvGmowfrJUeCoG.R5S2F01G=_54f9f_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220806152012epcas5p41ebe594bc59a4a0ac0733ea1c052f241
References: <20220806152004.382170-1-axboe@kernel.dk>
        <CGME20220806152012epcas5p41ebe594bc59a4a0ac0733ea1c052f241@epcas5p4.samsung.com>
        <20220806152004.382170-3-axboe@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

------W1bEPTvsorsTcy9-0QGogbD0KLvGmowfrJUeCoG.R5S2F01G=_54f9f_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Sat, Aug 06, 2022 at 09:20:03AM -0600, Jens Axboe wrote:
>bdev based polled O_DIRECT is currently quite a bit faster than
>passthru on the same device, and one of the reaons is that we're not
>able to use the bio caching for passthru IO.
>
>If REQ_POLLED is set on the request, use the fs bio set for grabbing a
>bio from the caches, if available. This saves 5-6% of CPU over head
>for polled passthru IO.

For passthru path, bio is always freed in the task-context (and not in
irq) so must this be tied to polled-io only? 

------W1bEPTvsorsTcy9-0QGogbD0KLvGmowfrJUeCoG.R5S2F01G=_54f9f_
Content-Type: text/plain; charset="utf-8"


------W1bEPTvsorsTcy9-0QGogbD0KLvGmowfrJUeCoG.R5S2F01G=_54f9f_--
