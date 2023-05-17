Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82247C7EE24
	for <linux-block@archiver.kernel.org>; Wed, 17 May 2023 02:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbjEQCWH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 May 2023 22:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbjEQCV7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 May 2023 22:21:59 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA3F59DF
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 19:21:43 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230517022140epoutp01747e488eeec01f4abd3e3bd1f06d6045~fzOwdos9P1068310683epoutp01o
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 02:21:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230517022140epoutp01747e488eeec01f4abd3e3bd1f06d6045~fzOwdos9P1068310683epoutp01o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684290100;
        bh=hh9AOH5Z6+Q4qtKEHWf8pxsRM/6yOBm4T7O51t8ive8=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=unfh36b9qzo/CN6fG5XUcxB0aKFBhS7a6gPH6YrvR7pMK0iD55tTctNNZTX6W4xUM
         pulOPe5SgicyUsBpVTTDnAQ4QbUGWUPAwD/FM5uA5mHZEUM3aT2VFBXFeqK1fr1bp3
         gLIypFt02uJ3i1YvSvnfFllwcMKTVqpZm/1cPJtw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230517022139epcas2p2f6cb82e61bf97fbe82f527ea4fb2510f~fzOv_fE2O1659216592epcas2p2d;
        Wed, 17 May 2023 02:21:39 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.101]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4QLcLC1v9zz4x9Q2; Wed, 17 May
        2023 02:21:39 +0000 (GMT)
X-AuditID: b6c32a47-e99fd70000002007-53-64643a335183
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        F7.91.08199.33A34646; Wed, 17 May 2023 11:21:39 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(2) [PATCH v2 08/14] scsi: add scsi_alloc_integrity_sgtables()
 for integrity process
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung CHOI <j-young.choi@samsung.com>
From:   Jinyoung CHOI <j-young.choi@samsung.com>
To:     "hch@lst.de" <hch@lst.de>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "kch@nvidia.com" <kch@nvidia.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230512135224.GE32242@lst.de>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230517022038epcms2p525403cf12b641f785647487c8b41a57c@epcms2p5>
Date:   Wed, 17 May 2023 11:20:38 +0900
X-CMS-MailID: 20230517022038epcms2p525403cf12b641f785647487c8b41a57c
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCJsWRmVeSWpSXmKPExsWy7bCmma6xVUqKQcsbTovVd/vZLF4e0rRY
        ufook8WiG9uYLP523WOymHToGqPF06uzmCz23tK2uLxrDpvF8uP/mCzWvX7PYvH7xxw2Bx6P
        8/c2snhsXqHlcflsqcemVZ1sHhMWHWD02H2zgc2jt/kdm8fHp7dYPPq2rGL0+LxJzqP9QDdT
        AHdUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0OVK
        CmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnALzAr3ixNzi0rx0vbzUEitDAwMjU6DC
        hOyM4/9msxVc4ajo+vaZpYFxFUcXIyeHhICJxMdd91m7GLk4hAR2MEqcufKZpYuRg4NXQFDi
        7w5hkBphgSSJGSfXsYPYQgJKEufWzGIEKREWMJC41WsOEmYT0JP4uWQGG0hYREBW4sqKepAw
        s8AnZon/7wwgNvFKzGh/ygJhS0tsX76VEcTmFNCROLFjI1RcQ+LHsl5mCFtU4ubqt+ww9vtj
        8xkhbBGJ1ntnoWoEJR783A0Vl5Q4dOgr2AkSAvkSGw4EQoRrJN4uPwBVoi9xrQNiFa+Ar8Sj
        149ZQWwWAVWJruUXmCBqXCSW/2xjhDhfW2LZwtfMICOZBTQl1u/Sh5iuLHHkFgtEBZ9Ex+G/
        7DAPNmz8jZW9Y94TJohWNYlFTUYTGJVnIcJ4FpJVsxBWLWBkXsUollpQnJueWmxUYAyP1uT8
        3E2M4OSr5b6DccbbD3qHGJk4GA8xSnAwK4nwBvYlpwjxpiRWVqUW5ccXleakFh9iNAV6ciKz
        lGhyPjD955XEG5pYGpiYmRmaG5kamCuJ80rbnkwWEkhPLEnNTk0tSC2C6WPi4JRqYDJ02fV5
        ddvdK0/eMxy9FfC19p9R1uElnTeC2VrmKcWVb6jakG96sSjdwIcz2/3Lyu4j8Yk/fI4m3ZpQ
        J5123OBwxZO/rw48fH/K+EOkcWNltnKUT7Pib4ej2QfaXczcmzb0Ltm1rUOTWXvywyP2vnc/
        hm+IaJq0guthOYMam0Ok47q1/AUBTCIJXCqrPzecPD9R5cD8nb/fHax4Wr+R+WLXEclKVct/
        syLDvNLc6r9XvOSV3nR7xbf1x6JTbxQbrJMU6uA7ctxf7V/yHme5/EI35v0ybw95F92d/yTr
        2YtVdT+8tsUL9YhESje5XZ3qbybb9OPJxHCfsBPz1t58IvB54ZGNOte2u9Wq3Iva8kuJpTgj
        0VCLuag4EQASSCZ0RwQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684
References: <20230512135224.GE32242@lst.de>
        <20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684@epcms2p1>
        <20230510085607epcms2p3d2b2dfc5db42f77c41f570c361a41c6a@epcms2p3>
        <CGME20230510084407epcms2p123f17696d3c30c749897eeaf2c4de684@epcms2p5>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>On Wed, May 10, 2023 at 05:56:07PM +0900, Jinyoung CHOI wrote:
>> + =C2=A0=20=C2=A0=20=C2=A0=20=C2=A0if=20(WARN_ON_ONCE(=21prot_sdb))=20=
=7B=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0/*=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20*=20This=20can=20happen=20if=20someone=20(e.g.=
=20multipath)=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20*=20queues=20a=20command=20to=20a=20device=20on=
=20an=20adapter=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20*=20that=20does=20not=20support=20DIX.=0D=0A>>=
=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20*/=0D=0A>>=20+=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0return=20BLK_STS_IOERR;=0D=0A>=0D=0A>Nit:=20expand=20the=
=20comment=20to=20take=20up=20all=2080=20characters=20now=20that=20you've=
=0D=0A>unindented=20it.=0D=0A=0D=0AOK.=20I=20will=20fix=20it.=20Thank=20you=
.=0D=0A=0D=0ABest=20Regards,=0D=0AJinyoung.
