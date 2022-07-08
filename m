Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE438C43334
	for <linux-block@archiver.kernel.org>; Fri,  8 Jul 2022 17:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238918AbiGHRuB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Jul 2022 13:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238664AbiGHRuA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Jul 2022 13:50:00 -0400
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92830248F2
        for <linux-block@vger.kernel.org>; Fri,  8 Jul 2022 10:49:57 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20220708174956usoutp014ee6993ba9bfa165d7eac3bf2b0f09e9~-6_5R5Anq1426414264usoutp01n;
        Fri,  8 Jul 2022 17:49:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20220708174956usoutp014ee6993ba9bfa165d7eac3bf2b0f09e9~-6_5R5Anq1426414264usoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1657302596;
        bh=PiGY4Xzma6ONTVUShHEIAuiU5s2HtKdx7CI8wbb+P/E=;
        h=From:To:CC:Subject:Date:References:From;
        b=gM9pGmLXJa9ORuSw1WIrMXiqxplycJWmb0BXqXhYRMSQVQY+6Hgie9cgx1+3390pX
         HfXxmeHbRlhHWKoZVuU97v3MZD/blm7ichmJJRZgnZH2ceYqdTuAPAY7lZIQhn8Bn8
         dZcEJy3AC+yTl6xkM8jUw8Y7u8vOohxc/eRmnUwI=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220708174951uscas1p1466268c7fb763ffd29cd90c54f3da017~-6_0MXU7P0962009620uscas1p1G;
        Fri,  8 Jul 2022 17:49:51 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id 67.6E.09760.F3E68C26; Fri, 
        8 Jul 2022 13:49:51 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220708174950uscas1p28249281e53bc42b8e148bb76745b39a0~-6_z6CKb-2800328003uscas1p2T;
        Fri,  8 Jul 2022 17:49:50 +0000 (GMT)
X-AuditID: cbfec36d-51bff70000002620-87-62c86e3f38e2
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id E5.29.57470.E3E68C26; Fri, 
        8 Jul 2022 13:49:50 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Fri, 8 Jul 2022 10:49:49 -0700
Received: from SSI-EX3.ssi.samsung.com ([105.128.5.228]) by
        SSI-EX3.ssi.samsung.com ([105.128.5.228]) with mapi id 15.01.2375.024; Fri,
        8 Jul 2022 10:49:49 -0700
From:   Vincent Fu <vincent.fu@samsung.com>
To:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "gost.dev@samsung.com" <gost.dev@samsung.com>,
        Vincent Fu <vincent.fu@samsung.com>
Subject: [PATCH for-next v2 0/2] null_blk: harmonize some module parameter
 and configfs options
Thread-Topic: [PATCH for-next v2 0/2] null_blk: harmonize some module
        parameter and configfs options
Thread-Index: AQHYkvMeeFGReLki60SrJFFPzlmW4Q==
Date:   Fri, 8 Jul 2022 17:49:49 +0000
Message-ID: <20220708174943.87787-1-vincent.fu@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsWy7djXc7r2eSeSDLa84rZYfbefzWLvLW0H
        Jo/LZ0s9Pm+SC2CK4rJJSc3JLEst0rdL4MpY/6G44BhLxfeVDYwNjNeYuxg5OCQETCT+fZLu
        YuTiEBJYySjRMvMxK4TTyiRx//JWdpiiTSvcIeJrGSV2/jjNBuF8ZJS4NvcLE4SzlFHiz/73
        rCAdbAKaEm/3F3QxcnKICKRJnLiygh3EZhaIkGheMI8ZxBYWSJT4eaKDBa6m9RwjhK0n8ejG
        KrAaFgEVidb/R1hBbF4Ba4nOi0/A4owCYhLfT61hgpgpLnHryXwwW0JAUGLR7D3MELaYxL9d
        D9kgbEWJ+99fQt2gJ3Fj6hQ2CFtbYtnC18wQ8wUlTs58wgJRLylxcMUNFpC/JAReskusvbEN
        aqiLxP1/99khbGmJv3eXMUEUtTNKzN34Bap7AqPE9SdSELa1xL/Oa1Cb+ST+/nrECAlSXomO
        NqEJjEqzkPwwC8l9s5DcNwvJfQsYWVYxipcWF+empxYb5qWW6xUn5haX5qXrJefnbmIEpovT
        /w7n7mDcceuj3iFGJg7GQ4wSHMxKIrzxyseThHhTEiurUovy44tKc1KLDzFKc7AoifMuy9yQ
        KCSQnliSmp2aWpBaBJNl4uCUamCavMN7o53QqaWPnux8d2eK4D97g+5dNipKn06+N/1doTbV
        tOjes4bMry937mL8VbiZW27j4+Cef3E/mbMaZyQH+7cd2Vrj2r/A7JSAy0y2479nztz56R2f
        a2rayV0r/yoderChrPCqcKnho7e2r/KizmSK+583ctWoydFq2rl2H9/6rz3dr2WmX0z61v1+
        452skCU6T/w0xHVXZX77cPP3lJJ770UKZ96Plv6uMDd3693wdEaFjX08Aa49N2cdyJebp/2x
        ZuOPmWJ55x6c+N7wyCluwqxzUhx1GqVVfI59z+TWP43YxDPfQaQgYcGztLkFefxZnuWhM7fu
        /r+0wr7lZmKVxNT1B7bf6eu7u9qzVImlOCPRUIu5qDgRAE8ne0KGAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsWS2cA0Sdcu70SSwY9VRhar7/azWey9pe3A
        5HH5bKnH501yAUxRXDYpqTmZZalF+nYJXBnrPxQXHGOp+L6ygbGB8RpzFyMHh4SAicSmFe5d
        jFwcQgKrGSX2777PCuF8ZJQ4tKGTCcJZyiix9fNbVpAONgFNibf7C7oYOTlEBNIkTlxZwQ5i
        MwtESDQvmMcMYgsLJEq0z7zGClPzYl8LlK0n8ejGKrAaFgEVidb/R8DivALWEp0Xn4DFGQXE
        JL6fWsMEMVNc4taT+WC2hICAxJI955khbFGJl4//sULYihL3v7+EukFP4sbUKWwQtrbEsoWv
        mSHmC0qcnPmEBaJeUuLgihssExhFZyFZMQtJ+ywk7bOQtC9gZFnFKF5aXJybXlFslJdarlec
        mFtcmpeul5yfu4kRGCOn/x2O3sF4+9ZHvUOMTByMhxglOJiVRHjjlY8nCfGmJFZWpRblxxeV
        5qQWH2KU5mBREud9GTUxXkggPbEkNTs1tSC1CCbLxMEp1cCU8KFgxv3a6xOlJs+Nz1g6TX1x
        hcUnEdntF2y5IlW63hrdunL/g+ad/J8c2zcXhvgtfnrwurJypN153baGS/x6D7Rtu0svlpc4
        fHXV47sQ1JueIP/RbY3BdY/D3+5Ojfp7faHmZ/5/+iI+H4vuuijouwkcmrjgtbf4pZ8GHnFH
        0k6de957+lROavqZ8NfWV+e0vw7LWf94Gd/nN5ONVzl02V6NOLnlvXFbbl/vl8gtLDcnnmtK
        bMqaW7Z006NLbI3lMbrvwr5xnW29sWyW+7SL7EammxU0m6t1Y86Hn59ROzFo1ueJt51endrc
        sSVd8820c3m7g+dXxJ/9eFxzovakJMa1BkcPRfU/97sS8sQlQ4mlOCPRUIu5qDgRALEwHzwA
        AwAA
X-CMS-MailID: 20220708174950uscas1p28249281e53bc42b8e148bb76745b39a0
CMS-TYPE: 301P
X-CMS-RootMailID: 20220708174950uscas1p28249281e53bc42b8e148bb76745b39a0
References: <CGME20220708174950uscas1p28249281e53bc42b8e148bb76745b39a0@uscas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

These patches add plumbing to allow some options that could formerly only b=
e
set via module parameters to now be set via configfs and vice versa.

Changes since v1:
 - fix documentation formatting in patch 1

Vincent Fu (2):
  null_blk: add module parameters for 4 options
  null_blk: add configfs variables for 2 options

 Documentation/block/null_blk.rst  | 22 ++++++++++++++++++
 drivers/block/null_blk/main.c     | 38 ++++++++++++++++++++++++++++---
 drivers/block/null_blk/null_blk.h |  2 ++
 3 files changed, 59 insertions(+), 3 deletions(-)

--=20
2.25.1
