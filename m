Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29104C433ED
	for <linux-block@archiver.kernel.org>; Mon,  3 May 2021 09:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E224B611CD
	for <linux-block@archiver.kernel.org>; Mon,  3 May 2021 09:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbhECJrx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 May 2021 05:47:53 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:40674 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbhECJrw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 May 2021 05:47:52 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210503094657epoutp01eaa0fe736a3bbe4b6fab5fba729a1cff~7hXJwaXyX1886218862epoutp01L
        for <linux-block@vger.kernel.org>; Mon,  3 May 2021 09:46:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210503094657epoutp01eaa0fe736a3bbe4b6fab5fba729a1cff~7hXJwaXyX1886218862epoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1620035217;
        bh=6ghgoB4TnA7TWVcDFf1GK6fBeufHqUl6D8pLjpjtkX8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ixmZPKtN3Adse/ZsgFVv1ZKORd3EwvAZBRTpCr8ycJ5P8ke+JxnwUT2qkIgDAMxbY
         wv9JvlRZfwDAP2R7joLzaZ1zJYCrxEnYa4rt4Rr7JpsX56cnvu5fyI29zkwdKdBfEu
         QhRf8UbA70wrvMvr4H1D7yHVgbOrRLEYu3X7OstQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210503094656epcas1p3e376a0341af929b7d396cff00942ead1~7hXJQ4vyL2291922919epcas1p36;
        Mon,  3 May 2021 09:46:56 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.163]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4FYdRL4TZMz4x9QB; Mon,  3 May
        2021 09:46:54 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        41.50.09736.E86CF806; Mon,  3 May 2021 18:46:54 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210503094654epcas1p3ce7761e2f0fc304d1c08a9b0bf0485ff~7hXGoOPzx1844118441epcas1p3E;
        Mon,  3 May 2021 09:46:54 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210503094654epsmtrp2b477cb39059bf659fad95cd831e3c4ce~7hXGneqRl1498814988epsmtrp2k;
        Mon,  3 May 2021 09:46:54 +0000 (GMT)
X-AuditID: b6c32a39-8d9ff70000002608-5e-608fc68e63e3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DD.F9.08637.E86CF806; Mon,  3 May 2021 18:46:54 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210503094653epsmtip24d20a8af3ae510d4bb3a7b7cf1c38b88~7hXGb7xse3202832028epsmtip2Z;
        Mon,  3 May 2021 09:46:53 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     bvanassche@acm.org, yi.zhang@redhat.com
Cc:     axboe@kernel.dk, bgoncalv@redhat.com, hch@lst.de,
        jaegeuk@kernel.org, linux-block@vger.kernel.org,
        ming.lei@redhat.com
Subject: Re: [PATCH v2] block: Improve limiting the bio size
Date:   Mon,  3 May 2021 18:28:50 +0900
Message-Id: <20210503092850.25122-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210429063901.9593-1-nanich.lee@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEJsWRmVeSWpSXmKPExsWy7bCmgW7fsf4Eg5crZC1W3+1ns9h1cT6j
        xbQPP5ktVq4+ymTxZP0sZou9t7QtDk1uZrK4fm4amwOHx+Ur3h6Xz5Z6bFrVyeax+2YDm8f7
        fVfZPD5vkgtgi8qxyUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ
        0HXLzAG6RkmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYGhQoFecmFtcmpeul5yf
        a2VoYGBkClSZkJOx+P0R5oItHBX3Vos1MJ5g62Lk5JAQMJFYNWkPexcjF4eQwA5GiesLelgh
        nE+MEkc6JzJBON8YJbasOg7kcIC1nJnpBxHfyyjRtnA5G4TzmVFi0YqlYHPZBHQk+t7eYgNp
        EBHQlpi3sgTEZBaokTh9CKxCWMBGYvnLXewgNouAqsTPQyvAbF4Ba4mZU1tYIa6Tl/hzv4cZ
        xOYEih/b/IAJokZQ4uTMJywgNjNQTfPW2cwQ9R/ZJf7eY4KwXSQez5jDCGELS7w6voUdwpaS
        +PxuL9jJEgLdjBLNbfMZIZwJjBJLni+D6jaW+PT5MyPE0ZoS63fpQ4QVJXb+nssIsZhP4t1X
        UGiBwoRXoqNNCKJEReJMy31mmF3P1+6Emugh0dP9FBq4fYwSr2d3MU5gVJiF5J9ZSP6ZhbB5
        ASPzKkax1ILi3PTUYsMCU+T43cQITpxaljsYp7/9oHeIkYmD8RCjBAezkghvwdr+BCHelMTK
        qtSi/Pii0pzU4kOMpsDQnsgsJZqcD0zdeSXxhqZGxsbGFiZm5mamxkrivOnO1QlCAumJJanZ
        qakFqUUwfUwcnFINTLLP1/4+f1Pjc7xw9W21yF1/T+ifeuJmxs4Ybi3fKL7y4KSOCKHc5P9V
        Bhtc2A0O6k/ST5S7rnbGsnqmx783IfZ9dxaa+fKeZpjUu57Na9MUe+/obWdWGUZ/mqp77e7i
        d4J69t5m3h2fXH7/z+Bbs/zWWc+/n/fbzuOcGliTvk2gaNLL3SVW9/5Jlhy7Xt15gWWNhsRJ
        /XDnxjkSQlE+zaVzP4cmblxhujY4/eJ/G+mbkWcYb4jGRJQLLHpt9Okps3DknQKTvweb//J8
        YDzzYN6RhFMrdSaeFNrEYJV7t6xIdve6jIozaU9t+f7b6yxZk/Igb8KTh4of4pz9Uqd28KyZ
        GHMneHXDKo6JEm/CGpRYijMSDbWYi4oTAfCbmrQlBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsWy7bCSvG7fsf4Egz9XWS1W3+1ns9h1cT6j
        xbQPP5ktVq4+ymTxZP0sZou9t7QtDk1uZrK4fm4amwOHx+Ur3h6Xz5Z6bFrVyeax+2YDm8f7
        fVfZPD5vkgtgi+KySUnNySxLLdK3S+DKWPz+CHPBFo6Ke6vFGhhPsHUxcnBICJhInJnp18XI
        xSEksJtR4vTclUBxTqC4lMTxE29ZIWqEJQ4fLoao+cgocX7BEmaQGjYBHYm+t7fA5ogI6EpM
        Oc0IUsMs0MIosb3xNytIjbCAjcTyl7vYQWwWAVWJn4dWgNm8AtYSM6e2sELskpf4c78HbCYn
        UPzY5gdMILaQgJXE5ranLBD1ghInZz4Bs5mB6pu3zmaewCgwC0lqFpLUAkamVYySqQXFuem5
        xYYFhnmp5XrFibnFpXnpesn5uZsYweGtpbmDcfuqD3qHGJk4GA8xSnAwK4nwFqztTxDiTUms
        rEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQQHpiSWp2ampBahFMlomDU6qBqe+L0JSSVV7Ot1SP
        PZsRvDrhXIpB008Ntjk5M/TaPosKeidr5oRK7DtYG2DR8nH/ix7POX0vb7JO9lvCyO0pmV0+
        cebEyQ5awVOcTvLL/BVhC9vOzyF554Al77wXm20NHC0PnFzkxx3pstJn8QvneskQcS6D44mn
        pEQev5HQW76O/eXpbz88lZIjr8nM5Vts7vZ1eivbPYvY9rofOvmeYckpZWZ7OWew7zbw8Nuu
        m245ufvrfOYcd5mM3DefnU7UdnmF2dSHt9xTYGbxnnfm6/Iw6cCz7tzzu59WBhd3JWS8iC57
        /PP1enWefRWvVnU9/ua/cfPNo1v9f7ce+rip9545287nnezBIZ2fD39QYinOSDTUYi4qTgQA
        4hVtP94CAAA=
X-CMS-MailID: 20210503094654epcas1p3ce7761e2f0fc304d1c08a9b0bf0485ff
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210503094654epcas1p3ce7761e2f0fc304d1c08a9b0bf0485ff
References: <20210429063901.9593-1-nanich.lee@samsung.com>
        <CGME20210503094654epcas1p3ce7761e2f0fc304d1c08a9b0bf0485ff@epcas1p3.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> > On 4/28/21 12:21 AM, Changheun Lee wrote:
> > > Actually I don't know why NULL pointer dereference is occurred with Bart's
> > > patch in blk_rq_map_kern(). And same problem have not occured yet in my
> > > test environment with Bart's patch.
> > > Maybe I missed something, or missunderstood?
> > 
> > The call trace that I shared on the linux-block mailing list was
> > encountered inside a VM that has a SATA disk attached to it and also a
> > SATA CD-ROM. Does replicating that setup allow to reproduce the NULL
> > pointer dereference that I reported?
> > 
> > Bart.
> 
> I can reproduce and see NULL pointer dereference in same call path without
> your patch. But I can't reproduced it with your patch.
> I tested in ubuntu via grub. SATA disk is attached only in my environment.
> Actually I didn't test in VM yet. I'll try.
> 
> Thanks,
> 
> Changheun.

NULL pointer dereference is not produced in my VM environment too.

Dear Bart, Yi
I'll prepare v9 patch including Bart's modification.
Could you please test it on your environment?

