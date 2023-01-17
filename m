Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B8B7C63797
	for <linux-block@archiver.kernel.org>; Tue, 17 Jan 2023 07:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbjAQHqp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Jan 2023 02:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235977AbjAQHql (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Jan 2023 02:46:41 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C2E241DA
        for <linux-block@vger.kernel.org>; Mon, 16 Jan 2023 23:46:31 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230117074626epoutp01cb62dddcba41653121861ace6cc17099~7CQEWKU2t2512025120epoutp01h
        for <linux-block@vger.kernel.org>; Tue, 17 Jan 2023 07:46:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230117074626epoutp01cb62dddcba41653121861ace6cc17099~7CQEWKU2t2512025120epoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1673941586;
        bh=Yec/0E0bL+VD8fbe6ginotwN+znLvc8d+4kHzHJzF3Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WgXvteB29fGIVchYly110f4axtPKvf5vtxgxSphB6q7966oLs31RiNhXq0FuIJdcM
         PNp75aJps6Xg2/SfD8qLDefML/CcL+Ddz8Xi9xWhKlKhWUtwF4VHBs6M3XX73BUTq5
         e1DuBCn5QDZfzWfDysHWJCnCP9VLw/+Qr0CWZ6hA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230117074626epcas5p214260eb7447de12401b4781691927791~7CQECAnbg1576515765epcas5p2I;
        Tue, 17 Jan 2023 07:46:26 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Nx1DK2Yq3z4x9Q3; Tue, 17 Jan
        2023 07:46:25 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        18.0F.62806.15256C36; Tue, 17 Jan 2023 16:46:25 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230117074624epcas5p2fda267723b6a95f7cbb7b759fce39e63~7CQCcHWQV2650226502epcas5p2K;
        Tue, 17 Jan 2023 07:46:24 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230117074624epsmtrp148b03b0a22a2410a29c01ea4a846b1fa~7CQCbYGUS3128431284epsmtrp1g;
        Tue, 17 Jan 2023 07:46:24 +0000 (GMT)
X-AuditID: b6c32a4a-c43ff7000000f556-bf-63c65251a8dc
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        82.8C.02211.05256C36; Tue, 17 Jan 2023 16:46:24 +0900 (KST)
Received: from green5 (unknown [107.110.206.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230117074623epsmtip18afca5c3a3dbdafd7dc2497c35b87e75~7CQBIZTFh2579525795epsmtip1O;
        Tue, 17 Jan 2023 07:46:23 +0000 (GMT)
Date:   Tue, 17 Jan 2023 13:16:00 +0530
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     bvanassche@acm.org, osandov@fb.com, j.granados@samsung.com,
        anuj20.g@samsung.com, ankit.kumar@samsung.com,
        vincent.fu@samsung.com, ming.lei@redhat.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 2/6] tests/nvme: add new test for rand-read on the nvme
 character device
Message-ID: <20230117074600.GA30000@green5>
MIME-Version: 1.0
In-Reply-To: <Y6XPs3MoyltFvEYT@bombadil.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmhm5g0LFkg7b5vBZrrvxmt2ia8JfZ
        YtqHn8wWS/c/ZLTYe0vb4saEp4wWhyY3M1kcvneVxeJxdwejA6fH5SveHhOb37F7bFrVyebx
        ft9VNo++LasYPT5vkgtgi8q2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvM
        TbVVcvEJ0HXLzAG6SUmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYFKgV5yYW1ya
        l66Xl1piZWhgYGQKVJiQnXFo4knmgi9SFTcPP2FsYHws2sXIySEhYCJxd+Yj1i5GLg4hgd2M
        Er87pjJCOJ8YJVb2X2IBqRIS+MYo8fWoXBcjB1hH811+iJq9jBKv7n9hhnCeMEr0P7jHCNLA
        IqAq0XTlPBtIA5uApsSFyaUgYREBDYl9E3qZQOqZQbad33iUCSQhLBAncXpPK1gvr4C2xO4/
        29kgbEGJkzOfsIDM4RQwk7j1wxUkLCqgLHFg23GwORICUzkk1n+YwAjxjovEixvr2CFsYYlX
        x7dA2VISL/vboOxkiUszzzFB2CUSj/cchLLtJVpP9TOD2MwCGRLTrx1jgrD5JHp/P2GCeJ5X
        oqNNCKJcUeLepKesELa4xMMZS6BsD4m3N9ZBQ7SNSaLh3VX2CYxys5C8MwvJCgjbSqLzQxPr
        LKAVzALSEsv/cUCYmhLrd+kvYGRdxSiZWlCcm55abFpglJdaDo/i5PzcTYzgRKrltYPx4YMP
        eocYmTgYDzFKcDArifD67TqcLMSbklhZlVqUH19UmpNafIjRFBg9E5mlRJPzgak8ryTe0MTS
        wMTMzMzE0tjMUEmcN3Xr/GQhgfTEktTs1NSC1CKYPiYOTqkGpkQplq7ndc750efzrl0+zTEj
        +9neKIsOIbHcxNNVvROmWsvcdbUJafq93meFqGMnh8Y60d7dqySuamw1m7307+NpO6w8sk8t
        Wzi1IPlV7tGqBR4vWZcLtd2MnVYw71GomO+SPY5HggoefM+JW7wo6ufXH5f6/zWxyTROO79v
        1vJDBzsLq35UZUXymE+y2OBVpLY0izXms+56u5zg1Ttl9U991XKavXS6eI/j3eWRNcZfs2KX
        uF93VzeUdMqyCn3l7/VjrtxCnnO1eqsKlzxeML/OSuR0+HdxwZ9rhZv8LJjkf4eIPLpYxrtt
        Gp9t/fRLfhPEFb6fa+eVe6G+/np45I1KpxmBK/avDL9k0NGvpMRSnJFoqMVcVJwIALqH8WQt
        BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsWy7bCSnG5A0LFkgzvP1SzWXPnNbtE04S+z
        xbQPP5ktlu5/yGix95a2xY0JTxktDk1uZrI4fO8qi8Xj7g5GB06Py1e8PSY2v2P32LSqk83j
        /b6rbB59W1YxenzeJBfAFsVlk5Kak1mWWqRvl8CVcWL9F8aCZRIVZ6b0sDcwrhfuYuTgkBAw
        kWi+y9/FyMUhJLCbUWLFvptMXYycQHFxieZrP9ghbGGJlf+es0MUPWKUeHbiFxtIgkVAVaLp
        ynk2kEFsApoSFyaXgoRFBDQk9k3oZQKpZxbYyyjx/MIdsEHCAnESp/e0MoLYvALaErv/bAeb
        IyTQwSRx6nYARFxQ4uTMJywgNrOAmcS8zQ+ZQeYzC0hLLP/HAWJyAoVv/XAFqRAVUJY4sO04
        0wRGwVlImmchaZ6F0LyAkXkVo2RqQXFuem6xYYFhXmq5XnFibnFpXrpecn7uJkZwZGhp7mDc
        vuqD3iFGJg7GQ4wSHMxKIrx+uw4nC/GmJFZWpRblxxeV5qQWH2KU5mBREue90HUyXkggPbEk
        NTs1tSC1CCbLxMEp1cDkF2C8Vvr3jFCd28l8UYtUfyZxhogLLX7ivE7Ym/vM0UUdb+7Zuf2d
        8UnvwKzDR1wdgzr0RSzm2lTdeLv66PLIuREJ242apgn/0TJLn/K/5s/FC58yRe+ufKeo5Zks
        v7W11kkpYk2KjtvF95vXNXA/6DZQWZS/1769iP/k7ZqztYwLTTwL5kU119oc+qZvYXSQ5Wz3
        NIn6DzOeH9ebvGW90tUpNm37YtaFGNRNY67yvPSRz9r8TpL0Q88n5v9OyOu11LvHfvSJZTza
        /+RjSpMYh/yfwpDCN+zbVkTtOPG10UnxTFtd2duI8PWZdi9Wi09eE93HsX7NtUeZq2Timj84
        pTxZ+n4962Lhy5clby5VYinOSDTUYi4qTgQAjRsH0PsCAAA=
X-CMS-MailID: 20230117074624epcas5p2fda267723b6a95f7cbb7b759fce39e63
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----HOtZ9yd3N7yF5SFbHINLR7X-T_3piWaZJDYS8aWXhrzmidxZ=_b2e36_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221221103532epcas5p2c806adb12a32e259438511a584216c11
References: <20221221103441.3216600-1-mcgrof@kernel.org>
        <CGME20221221103532epcas5p2c806adb12a32e259438511a584216c11@epcas5p2.samsung.com>
        <20221221103441.3216600-3-mcgrof@kernel.org> <20221223131137.GA27984@green>
        <Y6XPs3MoyltFvEYT@bombadil.infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

------HOtZ9yd3N7yF5SFbHINLR7X-T_3piWaZJDYS8aWXhrzmidxZ=_b2e36_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Fri, Dec 23, 2022 at 07:56:35AM -0800, Luis Chamberlain wrote:
>On Fri, Dec 23, 2022 at 06:41:37PM +0530, Kanchan Joshi wrote:
>> On Wed, Dec 21, 2022 at 02:34:37AM -0800, Luis Chamberlain wrote:
>> > This does basic rand-read testing of the character device of a
>> > conventional NVMe drive.
>> >
>> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
>> > ---
>> > tests/nvme/046     | 42 ++++++++++++++++++++++++++++++++++++++++++
>> > tests/nvme/046.out |  2 ++
>> > 2 files changed, 44 insertions(+)
>> > create mode 100755 tests/nvme/046
>> > create mode 100644 tests/nvme/046.out
>> >
>> > diff --git a/tests/nvme/046 b/tests/nvme/046
>> > new file mode 100755
>> > index 000000000000..3526ab9eedab
>> > --- /dev/null
>> > +++ b/tests/nvme/046
>> > @@ -0,0 +1,42 @@
>> > +#!/bin/bash
>> > +# SPDX-License-Identifier: GPL-3.0+
>> > +# Copyright (C) 2022 Luis Chamberlain <mcgrof@kernel.org>
>> > +#
>> > +# This does basic sanity test for the nvme character device. This is a basic
>> > +# test and if it fails it is probably very likely other nvme character device
>> > +# tests would fail.
>> > +#
>> > +. tests/nvme/rc
>> > +
>> > +DESCRIPTION="basic rand-read io_uring_cmd engine for nvme-ns character device"
>> > +QUICK=1
>> > +
>> > +requires() {
>> > +	_nvme_requires
>> > +	_have_fio
>> > +}
>> > +
>> > +device_requires() {
>> > +	_require_test_dev_is_nvme
>> > +}
>> > +
>> > +test_device() {
>> > +	echo "Running ${TEST_NAME}"
>> > +	local ngdev=${TEST_DEV/nvme/ng}
>> > +	local fio_args=(
>> > +		--size=1M
>> > +		--cmd_type=nvme
>> > +		--filename="$ngdev"
>> > +		--time_based
>> > +		--runtime=10
>> > +	) &&
>>
>> Is this && needed?
>
>This form was inspired by commit 238c7e0b by Bart, but yeah you're
>right, I can't see any reason for it, so we can clean zbd/010 from it too.
>>
>> > +	_run_fio_rand_iouring_cmd "${fio_args[@]}" >>"${FULL}" 2>&1 ||
>>
>> Something to change here (and therefore in other patches too).
>> If we change "cmd_type = something_random", test continues to show the
>> success while it should show failure.
>
>Definitely no bueno.
>
>> How about changing above line to:
>> _run_fio_rand_iouring_cmd "${fio_args[@]}" || fail=true
>
>We'd loose the 046.full log then.
>
>If we just return $? at the end of _run_fio_rand_iouring_cmd() that
>seems to fix the undetected error. Whatyda think?

It did not fix for me. It still shows test passed for "cmd_type=random".
How about this one instead-

_run_fio_rand_iouring_cmd "${fio_args[@]}" >>"${FULL}" || fail=true

it retains the full log, and shows the error when it occurs. 

>I noticed an odd thing in the last two patches which work for zone
>storage, if I change the runtime it doesn't take longer, so I think
>something is still off there too... can you take a look?

Runtime change works fine for first zoned test (i.e. read one). 
For the last one (i.e. zbd/012), fio fails early (that's why runtime
does not have any impact) because rw is set to randread along with
verify. It should rather be set to write.

------HOtZ9yd3N7yF5SFbHINLR7X-T_3piWaZJDYS8aWXhrzmidxZ=_b2e36_
Content-Type: text/plain; charset="utf-8"


------HOtZ9yd3N7yF5SFbHINLR7X-T_3piWaZJDYS8aWXhrzmidxZ=_b2e36_--
