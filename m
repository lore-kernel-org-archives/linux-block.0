Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C82BC433ED
	for <linux-block@archiver.kernel.org>; Thu, 22 Apr 2021 00:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 439DE613C2
	for <linux-block@archiver.kernel.org>; Thu, 22 Apr 2021 00:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235132AbhDVAKC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Apr 2021 20:10:02 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:63333 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235031AbhDVAKC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Apr 2021 20:10:02 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210422000926epoutp04f09d8e8346e0d7c18773d746eef467ec~4BYxVeLZ92129221292epoutp04x
        for <linux-block@vger.kernel.org>; Thu, 22 Apr 2021 00:09:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210422000926epoutp04f09d8e8346e0d7c18773d746eef467ec~4BYxVeLZ92129221292epoutp04x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1619050166;
        bh=iYCZTsdmadjPtS4tIrWvSpCZs4fnSJ67N85memmxcSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LYf3yya+d7apaWRopFnSEaFkkhNjBuFMbrRD2k2gqyHfno7g1D44rI3rAr98UxCh7
         5ndAfBozM3zB2GEF9U2+li33oQwNX+3cW0NrVUXdZS1qDYZELkFTTyyrPv5vkfJce0
         lc4latxGNovLjnS6cVyYUNkB8V8jFCcKeRQMxo+E=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210422000925epcas1p1baef0367eebb0f1638c572c4a10fd7f8~4BYwV6RL30712807128epcas1p1T;
        Thu, 22 Apr 2021 00:09:25 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.162]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4FQd834Q3fz4x9Pq; Thu, 22 Apr
        2021 00:09:23 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        FB.54.09824.3BEB0806; Thu, 22 Apr 2021 09:09:23 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210422000922epcas1p4bb2d0220652f3c497f063719f82bc829~4BYuK4_1_0631206312epcas1p4Z;
        Thu, 22 Apr 2021 00:09:22 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210422000922epsmtrp15c42b0eed21fc791ec58eaff67834661~4BYuJvxTX0831008310epsmtrp1I;
        Thu, 22 Apr 2021 00:09:22 +0000 (GMT)
X-AuditID: b6c32a37-04bff70000002660-3c-6080beb32333
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        DE.87.08163.2BEB0806; Thu, 22 Apr 2021 09:09:22 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210422000922epsmtip1c0d079da380b74ce0e61bedc44b94f4f~4BYt18qss0645406454epsmtip1X;
        Thu, 22 Apr 2021 00:09:22 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     bvanassche@acm.org
Cc:     Johannes.Thumshirn@wdc.com, asml.silence@gmail.com,
        axboe@kernel.dk, damien.lemoal@wdc.com, gregkh@linuxfoundation.org,
        hch@infradead.org, jisoo2146.oh@samsung.com,
        junho89.kim@samsung.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com,
        mj0123.lee@samsung.com, nanich.lee@samsung.com, osandov@fb.com,
        patchwork-bot@kernel.org, seunghwan.hyun@samsung.com,
        sookwan7.kim@samsung.com, tj@kernel.org, tom.leiming@gmail.com,
        woosung2.lee@samsung.com, yt0928.kim@samsung.com
Subject: Re: [PATCH v8] bio: limit bio max size
Date:   Thu, 22 Apr 2021 08:51:24 +0900
Message-Id: <20210421235124.31579-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <55adfb07-7f10-7ad6-e05d-7aeb7d9c3b29@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf0xbVRTHue+1r+VHzVsHeMUwu6dGYQLtusIdDoX9YC/DJShmMcu0vMAL
        RUtb+4qZcxqkha1AaLETtDDcYENBobOwDRoLSxecbBNC2KZBB6sQl5nwYyCEARNLC8p/58fn
        nu85594rxMUPiShhvsbA6jWMmiJCeJeuxkjj2ruLsqVt7dGoruUSQN/etRCoevoRjkpOzGPI
        2Ogg0A1rA4Yqxov56HHZCIbmvBxyD29DQ646AnlsRgzVtNfh6M7oTQG6OnKbh7znqnDU3zfD
        R/VjqWjx616AphZ+EaDrnTYcOdyPiNRIeuhWBl1lnBTQXfa7Arr9m1h66OdC2tliJuie098J
        6Knu2wRd2dEC6FnnFvrElXIsM/SwepeKZXJZvYTV5Ghz8zV5KVRGlnKPUpEolcXJdqIkSqJh
        CtgUau9rmXHp+WrfpJTkA0Zd6AtlMhxHJbyyS68tNLASlZYzpFCsLletk0l18RxTwBVq8uJz
        tAXJMql0u8JHZqtVrdfe0Vn5RztHLuBFYAEvA8FCSO6A9dYzoAyECMVkJ4Derkks4MwAaHf8
        s5aZBdDZ+zlv/cjMtB0PJFwANg39wf+PGl8s9lME+RKsnBgmVu1wMhIO/T3vL4WTpTw4bLrj
        T2wmE+DU0pS/Ex75PDy1WOuDhEIR+TJcdLwaUHsGLo9W+JFgX/hG91l/fRG5CfZ9Oe63cR9j
        vFi7NtCKENYuaQP2XrgybVrrejP861qHIGBHwQeWUsFqP5AsB9BY+hUIOFYAz91vwgKUHM7M
        zvobwskY6HAlBMJbYdfSaRAQfgJOzlXwVxFIiuDJUnEAeQ7eNI3i61r3W7vWKtJwrO37tZVW
        AuiqbhJYgcS+YR77hnns/yufAXgLiGR1XEEey8l08o1X7AT+tx+b1AmqJ6bjPQATAg+AQpwK
        F7VyRdliUS7z4TFWr1XqC9Us5wEK37Kr8KiIHK3v82gMSpliu1wuRzsSkxIVcupJUd6ej7LF
        ZB5jYN9jWR2rXz+HCYOjijDrIeW9toOmsCDR4PGj2OBbb6aZ1BfjnFHllgjl+ccJHrfkiLt1
        9HrJFTR4yP2nN6uHiLkVvaV409mqF51YWHXzbxPaL041p28rD09T/Pi62byvzxtGpmkbY4f7
        LJXHdLOuB5/UPluQeT7fZa1P/jQ4I9F8OEVkzsB3p0hCcGV/0JFSleKe9/L7HY1tT+9MnU+9
        rFV95vAkLhirZz5eCP214al5W88P744tH6ivecFKDTxUNiQ3hc5FHI9YOWBxpiccXOa/YXjb
        tI8JX2L2a8wDrnrKrYzFf7/Ak2tCen+yWUatu7NEJmwARUqSbfsbRM0no0FNSX90kCOueTJN
        nEHxOBUji8X1HPMvw/EZoIQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsWy7bCSnO6mfQ0JBl8361vMWbWN0WL13X42
        i2kffjJbtLZ/Y7JoXryezeL0hEVMFj1Pmlgt/nbdY7L4+rDYYu8tbYvLu+awWRya3MxkMX3z
        HGaLa/fPsFscvneVxeLhkonMFudOfmK1mPfYweLX8qOMFu9/XGe3OLVjMrPF+r0/2RzEPC5f
        8faY2PyO3WPnrLvsHptXaHlcPlvqsWlVJ5vH/rlr2D3e77vK5tG3ZRWjx+dNch7tB7qZArij
        uGxSUnMyy1KL9O0SuDLWHo8rmMBasePeBuYGxh/MXYycHBICJhKfPswCsrk4hAR2MEqsP7OX
        ESIhJXH8xFvWLkYOIFtY4vDhYoiaj4wSJ7fNYQKpYRPQkeh7e4sNxBYREJO4/OUbI0gRs8AC
        FomDO0+wgySEBfQl3v9+D7aNRUBVYsqv2YwgQ3kFrCV+rbeH2CUv8ed+D1gJJ1D49L6FLCC2
        kICVxJJ9R8Hm8woISpyc+QQszgxU37x1NvMERoFZSFKzkKQWMDKtYpRMLSjOTc8tNiwwykst
        1ytOzC0uzUvXS87P3cQIjkwtrR2Me1Z90DvEyMTBeIhRgoNZSYR3bXFDghBvSmJlVWpRfnxR
        aU5q8SFGaQ4WJXHeC10n44UE0hNLUrNTUwtSi2CyTBycUg1M9pKzS8KDlNa/tVLYzbRRqGhD
        I6tznpT+Qr8Vzk6r8gUXRs27c3rPzt1HnBmPeZr0Stn/y49WLZuTrfe2V6ovMqtr4b4dfeaV
        ORN4zS02aVz9si3tjsAteQn3Bfuu8884uyapuqnEtWGW7+9lTzpEvKbyZbzy1p101fYit/Xp
        lNBFisvf3zrzz3JekXL21jnTzJdfKD8/sWSxk3KzWfdRi8xmkdOaK0wfXazYcdGq78iTm5/O
        zX/mFxU+8/5Cv43/12ovM3ViUWeVSb/FE7Wvcc3u3b93yiV6PbbZPFm2Prv8WB4f6/v1973M
        eXdmXp2/5sT7nafZLbjSvePnHYwSnndsrXOAQU3/seqQpduvKLEUZyQaajEXFScCAAbcZ8w7
        AwAA
X-CMS-MailID: 20210422000922epcas1p4bb2d0220652f3c497f063719f82bc829
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210422000922epcas1p4bb2d0220652f3c497f063719f82bc829
References: <55adfb07-7f10-7ad6-e05d-7aeb7d9c3b29@acm.org>
        <CGME20210422000922epcas1p4bb2d0220652f3c497f063719f82bc829@epcas1p4.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> On 4/21/21 2:47 AM, Changheun Lee wrote:
> > bio size can grow up to 4GB when muli-page bvec is enabled.
> > but sometimes it would lead to inefficient behaviors.
> > in case of large chunk direct I/O, - 32MB chunk read in user space -
> 
> This patch looks good to me, hence:
> 
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> 
> Do you plan to submit a dm-crypt patch that limits the bio size when 
> using dm-crypt to the bio size of the underling device?
> 
> Thanks,
> 
> Bart.

Yes, I'm preparing a dm-crypt patch. I'll upstream after applying of this.
Thank you for your review, and advice. :)

Thanks,

Changheun Lee.
