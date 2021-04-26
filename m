Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFBBC433ED
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 08:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16AAC6117A
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 08:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbhDZIx1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Apr 2021 04:53:27 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:29569 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbhDZIx0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Apr 2021 04:53:26 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210426085243epoutp0447e94e6617bd4d5afdecd10bb378b06b~5XGzVD0jE2599425994epoutp04V
        for <linux-block@vger.kernel.org>; Mon, 26 Apr 2021 08:52:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210426085243epoutp0447e94e6617bd4d5afdecd10bb378b06b~5XGzVD0jE2599425994epoutp04V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1619427163;
        bh=f9Eupx/TXAGTQUqsg/ciIjnw3Q1j3Ju/GDoVYdQrajs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BJ7wXWILrmAsIEqhRE0ADDmekpmg6/BOijYHuVzw61yZ6i+poeeehJOTKlenAWd3l
         KtiPA3FnrJJkgr0QPcqJH2LVkFITV9BBdI+twjTy7BhSLTe2WAyZNI+WinpZm7Ei/T
         ePeFPjEdwe97UcW5Nb8bTZ8X1DevcdfvJgQAHlrc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210426085243epcas1p2ffdd5b64db18e40d38cb2e737edae518~5XGy4OqRv1324913249epcas1p2W;
        Mon, 26 Apr 2021 08:52:43 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.165]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4FTJZ15bT8z4x9QJ; Mon, 26 Apr
        2021 08:52:41 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        9C.29.09578.95F76806; Mon, 26 Apr 2021 17:52:41 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210426085241epcas1p46ed8de18a98c40218dacd58fc4b25ff9~5XGxWZtAw2559225592epcas1p42;
        Mon, 26 Apr 2021 08:52:41 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210426085241epsmtrp161fb8a4ef8033089fcbbee5d963addfe~5XGxVnIGH2409524095epsmtrp1Y;
        Mon, 26 Apr 2021 08:52:41 +0000 (GMT)
X-AuditID: b6c32a35-58cdfa800000256a-94-60867f59a681
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        05.DF.08163.95F76806; Mon, 26 Apr 2021 17:52:41 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210426085241epsmtip222c6f9899cac1048305a3ecf9d08cb4e~5XGxG93iA1333913339epsmtip2-;
        Mon, 26 Apr 2021 08:52:41 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     bvanassche@acm.org
Cc:     yi.zhang@redhat.com, axboe@kernel.dk, bgoncalv@redhat.com,
        hch@lst.de, jaegeuk@kernel.org, linux-block@vger.kernel.org,
        ming.lei@redhat.com
Subject: Re: [PATCH v2] block: Improve limiting the bio size
Date:   Mon, 26 Apr 2021 17:34:42 +0900
Message-Id: <20210426083442.5831-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <CAHj4cs9E+9n9M6W59LuTWQbbhTzMGgi8KBPaN+cAYC3ypC3dCg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0xbVRTHvX3t4zFpfeuQ3XSJ1heWhWFLS2n3QFCToTbbTEr2V8mS8kKf
        hVhem76WOZZMIqPZKmF0NSQrTDQjW6GyDgLalQCmjjAFpvJDBFa7mIaFacdcxxIQE9s+UP47
        59zP937POfdiiLgdlWC1jJ22MZSZQPfwv/4uTy7Tf+ysUtx5nk/6I5dQMvRzFyDbn2wgZI9/
        nEfGAl6EHFnKJ8OeJh65cK8dfRvTzs4d185OO7QDvRdR7fBiI6pdG51HtYmBV3Ropbm0hqaM
        tE1KM9UWYy1jKiOOnzQcNag1CqVMWUweIaQMVUeXEeUndLJ3a83JbghpPWV2JEs6imWJgjdL
        bRaHnZbWWFh7GUFbjWarUmGVs1Qd62BM8mpLXYlSoShUJ8kqc831doH1R+yjRMCDNoK2DBfI
        xCBeBJcm3cAF9mBiPAjgwkqCxyVPAWz5/VsBlyQA/KPTB3Ykv8YmtiUhAIPzm8h/1HwomqZQ
        /HXYGl9CU3E2ngNnnz1PKxDcDeD6J61I6mAfXgpvrIbSnfDxg/DzWx5BKhbiJfDB0LKAs3sV
        bkVbkjyGZeIV8EaQ5pC98PsrMX4qRpJI01BHugmIr2fA8b6u7enK4QVPnM/F++CjicHtugSu
        XnJmcIJPAWxydgEuaQOw++F1Hkep4NNEAqScETwPBkIFXPk1ePvvq4BzFsHH6y2CFAJxIbzg
        FHNILpw6H0V2vB723d6+UQvn4hE+t61uAPvdHn4bkHp3DeTdNZD3f+cvANILcmgrW2eiWaVV
        ufuNB0D6gx5WB4E7/kQeBjwMhAHEECJbiIaaq8RCI3WmgbZZDDaHmWbDQJ3cthuRvFxtSf5w
        xm5QqgtVKhVZpDmiUauI/ULT0bNVYtxE2ekPadpK23Z0PCxT0sh7cd5//62OzGsfNOgDWZM3
        R8/NNa8Nng7Cy753bFl3Kw36xWNeUb9L5lKdNy6MiH6KyTcnu4YbRt7L6/DFOmbeX84fm9ko
        zr362T+/3FN2PQ5feXBwyTpWITB0r05sIsPjxYX5TJZ+7yGxtPOa81z0Zt9mZ8Rsbw1MCda6
        70xrRIODPd/crQxUxHrI038eoG+ViAjZ+Mow49rqf+GZrpfK171xQnKK+aGA1u//a1TTc3lK
        Z2oeql8881to5P6pmVo/vhXR1B+aFB57dDY73m4Lnow2OSpzI8XNUX9OHlPqdiKL5YW+6PLW
        kK9oesy3ckCxIfyy/yLLvtQ8wfC/IvhsDaU8jNhY6l+TvPOCKQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsWy7bCSvG5kfVuCwaQbAhar7/azWey6OJ/R
        YtqHn8wWK1cfZbJ4sn4Ws8XeW9oWhyY3M1lcPzeNzYHD4/IVb4/LZ0s9Nq3qZPPYfbOBzeP9
        vqtsHp83yQWwRXHZpKTmZJalFunbJXBlLJvGWnCeo+Lz+slsDYwT2LsYOTkkBEwkbjw5ztjF
        yMUhJLCDUWJ23yomiISUxPETb1m7GDmAbGGJw4eLIWo+Mkp0d18Fa2YT0JHoe3uLDcQWERCT
        uPzlG9ggZoHZjBJP2r+AFQkL2Egsf7kLzGYRUJWYt2EyK4jNK2Al8WDrbVaIZfISf+73MIMs
        4xQIlFi+IxUkLCQQIPHyyTpGiHJBiZMzn7CA2MxA5c1bZzNPYBSYhSQ1C0lqASPTKkbJ1ILi
        3PTcYsMCo7zUcr3ixNzi0rx0veT83E2M4ADX0trBuGfVB71DjEwcjIcYJTiYlUR42Xa1Jgjx
        piRWVqUW5ccXleakFh9ilOZgURLnvdB1Ml5IID2xJDU7NbUgtQgmy8TBKdXAtO/KGzlOZncF
        ps7qY/6xottezxM7GK9R2dvItr634Ea+evtDMxtv+/e9c1eEfwqek+HzjWGjKtsnrwna0/s/
        /y5mW8pz6NLMY+cvb/p9vcjwjo5JsEHMlx+XbjX0VzQsLjs759LGFCWR86efeR82LDhwuv9N
        ce07k8j5HLpbNKTXFfEpqUz2+v9NZ4Xeqw8RuvP8zB7aJ4u5vg9c9OHB7ZDNXke/PM/SvxD4
        Klt33frj3xpPxa19eHTivM9e8+Wd54meWpjyPG+p03qT2LuN7L45Bjr3ev0Z/m6reLZ1mRRf
        /M5Ptq9u31c2qnNc807iYq5Gw4O67WGtFamzp8cqCLQE7Wz5a3nthcoNz/lZ2UosxRmJhlrM
        RcWJAFUkZpjfAgAA
X-CMS-MailID: 20210426085241epcas1p46ed8de18a98c40218dacd58fc4b25ff9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210426085241epcas1p46ed8de18a98c40218dacd58fc4b25ff9
References: <CAHj4cs9E+9n9M6W59LuTWQbbhTzMGgi8KBPaN+cAYC3ypC3dCg@mail.gmail.com>
        <CGME20210426085241epcas1p46ed8de18a98c40218dacd58fc4b25ff9@epcas1p4.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> Hi Jens/Bart
> CKI reproduced the boot panic issue again with the latest
> linux-block/for-next[1] today, then I checked the patch 'bio: limit
> bio max size'[2] found Bart's fix patch does not fold in that commit,
> could you help recheck it, thanks.
> 
> [1]
> Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
> Commit: ffa77af5731d - Merge branch 'for-5.13/io_uring'
> into for-next
> [2] bio: limit bio max size
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-next&id=42fb54fbc7072da505c1c59cbe9f8417feb37c27
> 
> Thanks
> Yi
> >
> > Since I had to shuffle patches anyway, I folded in this fix. Thanks
> > Bart.
> >
> > --
> > Jens Axboe
> >

Should we check queue point in bio_max_size()?
__device_add_disk() can be called with "register_queue=false" like as
device_add_disk_no_queue_reg(). How about below?

unsigned int bio_max_size(struct bio *bio)
{
	struct request_queue *q;

	q = (bio->bi_bdev) ? bio->bi_bdev->bd_disk->queue : NULL;
	return q ? q->limits.bio_max_bytes : UINT_MAX;
}
