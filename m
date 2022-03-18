Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3994FC433FE
	for <linux-block@archiver.kernel.org>; Fri, 18 Mar 2022 12:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236335AbiCRMj7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Mar 2022 08:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236328AbiCRMj6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Mar 2022 08:39:58 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3F318615B
        for <linux-block@vger.kernel.org>; Fri, 18 Mar 2022 05:38:38 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id b24so10078293edu.10
        for <linux-block@vger.kernel.org>; Fri, 18 Mar 2022 05:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=emv9wIoHuW/0+Mue7gkgcmWzRTn4PFfkagkWpakJcrs=;
        b=M5wQfmq/z/FKPVjq+47Po/RqEbKuMvj67UfLqVzJh6IuKsdyQRKGIUb/wUr82yQrrb
         K9wnhVIUM4OGBonp9Fsu2Tb6UFi0C8hgscjGrK1dfexVce4BseOJnrFELR+Pb5lh9Mz/
         lPG7rAVJXzcuD4WETVCePZQ/xj4Wsi+mEWI5wN89AL10POfVlj+vuOkinovmCOtbye7e
         tqyf4BFg8xbvsA4lcpi5U7Mb/Gr6nWREB9mSjVM6zwIHRDpKBw9y50PyHsb4yP8QSC9W
         qwtXResN/2RcvxFr12EhieqLkDCuW+VqaW0pwGGcXYKwNLtohRUovzUBfEA567AVKQcW
         x2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=emv9wIoHuW/0+Mue7gkgcmWzRTn4PFfkagkWpakJcrs=;
        b=0sD5M48eAuiTkUt/1WMprELTyhwutDu2ZxNyWli7IuoOzKohWvyZAjfbR1IjldrO6O
         CEP62d0TxyZM+kIgO6OC3Q+RGKqViLFu202DNGrNIcru3NVg3ujx1f3V2KIt3AViwnbZ
         KINUJbL8T6IWX9koSaM6Q48P21u5WtwezFNfRhwSeLbRmzVmRxG6+h/9jbTb7W2fkEd3
         0fGn2UfFfMSPKasfYg9ls9/At0gfEcNtbRiTEHG8g5AELFskbQMu4/hOnhoHNWsMsxEW
         0T3Pg8LoVz1pPD1HWYQsULu29XLdObvGEtyyQH8WD6Yi4JHtqGOCATmGeOjmOQP0g7ag
         Byxw==
X-Gm-Message-State: AOAM53380ECNX00B4Nt8F7bj61ykFPrzxlgL6qASLDz+jXRBOXTqyX3F
        0Kr6XEUiX19h4CY5Euju1zuTbQ==
X-Google-Smtp-Source: ABdhPJzJutF6wsaWpy3KsAJ9JxoY2Wo2IZxzKHylfpk0PzAV7KubDisRYh65NZ26JNTBQsAtDHRiIA==
X-Received: by 2002:a05:6402:1e8b:b0:3da:58e6:9a09 with SMTP id f11-20020a0564021e8b00b003da58e69a09mr9048801edf.155.1647607117030;
        Fri, 18 Mar 2022 05:38:37 -0700 (PDT)
Received: from mbp-di-paolo.station (net-2-34-190-150.cust.vodafonedsl.it. [2.34.190.150])
        by smtp.gmail.com with ESMTPSA id qk9-20020a1709077f8900b006dfbc4b9b83sm593907ejc.163.2022.03.18.05.38.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Mar 2022 05:38:36 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH -next 00/11] support concurrent sync io for bfq on a
 specail occasion
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <11fda851-a552-97ea-d083-d0288c17ba53@huawei.com>
Date:   Fri, 18 Mar 2022 13:38:35 +0100
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, cgroups@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, yi.zhang@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <1AE1457D-AAE1-4A13-8593-451E9396028A@linaro.org>
References: <20220305091205.4188398-1-yukuai3@huawei.com>
 <e299180e-cdbd-0837-8478-5e397ac8166b@huawei.com>
 <11fda851-a552-97ea-d083-d0288c17ba53@huawei.com>
To:     "yukuai (C)" <yukuai3@huawei.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,
could you please add pointers to the thread(s) where we have already =
revised this series (if we have). I don't see any reference to that in =
this cover letter.

Paolo

> Il giorno 17 mar 2022, alle ore 02:49, yukuai (C) <yukuai3@huawei.com> =
ha scritto:
>=20
> friendly ping ...
>=20
> =E5=9C=A8 2022/03/11 14:31, yukuai (C) =E5=86=99=E9=81=93:
>> friendly ping ...
>> =E5=9C=A8 2022/03/05 17:11, Yu Kuai =E5=86=99=E9=81=93:
>>> Currently, bfq can't handle sync io concurrently as long as they
>>> are not issued from root group. This is because
>>> 'bfqd->num_groups_with_pending_reqs > 0' is always true in
>>> bfq_asymmetric_scenario().
>>>=20
>>> This patchset tries to support concurrent sync io if all the sync =
ios
>>> are issued from the same cgroup:
>>>=20
>>> 1) Count root_group into 'num_groups_with_pending_reqs', patch 1-5;
>>>=20
>>> 2) Don't idle if 'num_groups_with_pending_reqs' is 1, patch 6;
>>>=20
>>> 3) Don't count the group if the group doesn't have pending requests,
>>> while it's child groups may have pending requests, patch 7;
>>>=20
>>> This is because, for example:
>>> if sync ios are issued from cgroup /root/c1/c2, root, c1 and c2
>>> will all be counted into 'num_groups_with_pending_reqs',
>>> which makes it impossible to handle sync ios concurrently.
>>>=20
>>> 4) Decrease 'num_groups_with_pending_reqs' when the last queue =
completes
>>> all the requests, while child groups may still have pending
>>> requests, patch 8-10;
>>>=20
>>> This is because, for example:
>>> t1 issue sync io on root group, t2 and t3 issue sync io on the same
>>> child group. num_groups_with_pending_reqs is 2 now.
>>> After t1 stopped, num_groups_with_pending_reqs is still 2. sync io =
from
>>> t2 and t3 still can't be handled concurrently.
>>>=20
>>> fio test script: startdelay is used to avoid queue merging
>>> [global]
>>> filename=3D/dev/nvme0n1
>>> allow_mounted_write=3D0
>>> ioengine=3Dpsync
>>> direct=3D1
>>> ioscheduler=3Dbfq
>>> offset_increment=3D10g
>>> group_reporting
>>> rw=3Drandwrite
>>> bs=3D4k
>>>=20
>>> [test1]
>>> numjobs=3D1
>>>=20
>>> [test2]
>>> startdelay=3D1
>>> numjobs=3D1
>>>=20
>>> [test3]
>>> startdelay=3D2
>>> numjobs=3D1
>>>=20
>>> [test4]
>>> startdelay=3D3
>>> numjobs=3D1
>>>=20
>>> [test5]
>>> startdelay=3D4
>>> numjobs=3D1
>>>=20
>>> [test6]
>>> startdelay=3D5
>>> numjobs=3D1
>>>=20
>>> [test7]
>>> startdelay=3D6
>>> numjobs=3D1
>>>=20
>>> [test8]
>>> startdelay=3D7
>>> numjobs=3D1
>>>=20
>>> test result:
>>> running fio on root cgroup
>>> v5.17-rc6:       550 Mib/s
>>> v5.17-rc6-patched: 550 Mib/s
>>>=20
>>> running fio on non-root cgroup
>>> v5.17-rc6:       349 Mib/s
>>> v5.17-rc6-patched: 550 Mib/s
>>>=20
>>> Yu Kuai (11):
>>>    block, bfq: add new apis to iterate bfq entities
>>>    block, bfq: apply news apis where root group is not expected
>>>    block, bfq: cleanup for __bfq_activate_requeue_entity()
>>>    block, bfq: move the increasement of =
'num_groups_with_pending_reqs' to
>>>      it's caller
>>>    block, bfq: count root group into 'num_groups_with_pending_reqs'
>>>    block, bfq: do not idle if only one cgroup is activated
>>>    block, bfq: only count parent bfqg when bfqq is activated
>>>    block, bfq: record how many queues have pending requests in =
bfq_group
>>>    block, bfq: move forward __bfq_weights_tree_remove()
>>>    block, bfq: decrease 'num_groups_with_pending_reqs' earlier
>>>    block, bfq: cleanup bfqq_group()
>>>=20
>>>   block/bfq-cgroup.c  | 13 +++----
>>>   block/bfq-iosched.c | 87 =
+++++++++++++++++++++++----------------------
>>>   block/bfq-iosched.h | 41 +++++++++++++--------
>>>   block/bfq-wf2q.c    | 56 +++++++++++++++--------------
>>>   4 files changed, 106 insertions(+), 91 deletions(-)
>>>=20

