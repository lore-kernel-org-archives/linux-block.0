Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD77C433F5
	for <linux-block@archiver.kernel.org>; Tue, 31 May 2022 08:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244895AbiEaIgW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 May 2022 04:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243388AbiEaIgV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 May 2022 04:36:21 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FEA6F4AF
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 01:36:18 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 129-20020a1c0287000000b003974edd7c56so793688wmc.2
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 01:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unimore.it; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FIJm64zSOV70KcmATQ1QKKdd03bwiTpTbvXIZEBOtyU=;
        b=XAUy8Fy8mFRUhRv9O+rzT5F0TRfZRlE1gqkce0PLn2tBFnDoJXg9NnOl20ZvpeBleX
         Pd3EwavEBA+X5OJVCi9qFYtKXBjUT3kqUhLoWp78FP1WQEZ9oi6NW6tegoAj9TT5Mo+y
         Z0LoNo7mtMgpknC7BukFxusRJyrrYBvSvY/I0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FIJm64zSOV70KcmATQ1QKKdd03bwiTpTbvXIZEBOtyU=;
        b=ZEDPbh+HYQTLhKTplKeFcCyJkmbmmOqUMP8JXCTUou777FzZjuLzCoewfEPze0kEzA
         yv/kymNVBJzHdcfNk7aAEjjfZe6zCyVvhGJLh24+u8d1GuialU6putvBhgudsb6Db417
         qgXbpW/pil5LYwasVDJRv/IjyC64TGlmeHovAVONdoE3GGBNO/mf+V90ytLPV9rswiRC
         cYAoisisab1b3dBolTYoazngYCs3U015ymhSsIWXwzxm7CRSCYtFqG35UvqiA95e1h4k
         zS9DFPTfWJ6nff2Tm1nYNFlgAqzJtZ9up13zvnGqi72fchLt7tD8GB8u7/GXlfp28aTh
         9RoA==
X-Gm-Message-State: AOAM531zz9uiDzYMRg7c85z8yJ/wF1oghF6Z8kmf+Dvhq//Umi3qkqul
        DZF/BG/BxpCMpP9+YCcfDdGm
X-Google-Smtp-Source: ABdhPJzNhHkK2WK8mx9RSNqYXFEmnVc9sZGRQgQLoJwQ96U3iKwhVj3svUJUaruwq8uR6Pe8nE5LqQ==
X-Received: by 2002:a1c:f208:0:b0:39c:1282:3d04 with SMTP id s8-20020a1cf208000000b0039c12823d04mr6744485wmc.26.1653986177218;
        Tue, 31 May 2022 01:36:17 -0700 (PDT)
Received: from mbp-di-paolo.station (net-93-144-98-177.cust.vodafonedsl.it. [93.144.98.177])
        by smtp.gmail.com with ESMTPSA id az18-20020adfe192000000b0021020517639sm8392803wrb.102.2022.05.31.01.36.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 May 2022 01:36:16 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH -next v7 2/3] block, bfq: refactor the counting of
 'num_groups_with_pending_reqs'
From:   Paolo VALENTE <paolo.valente@unimore.it>
In-Reply-To: <efe01dd1-0f99-dadf-956d-b0e80e1e602c@huawei.com>
Date:   Tue, 31 May 2022 10:36:15 +0200
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, yi.zhang@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <1803FD7E-9FB1-4A1E-BD6D-D6657006589A@unimore.it>
References: <20220528095020.186970-1-yukuai3@huawei.com>
 <20220528095020.186970-3-yukuai3@huawei.com>
 <0D9355CE-F85B-4B1A-AEC3-F63DFC4B3A54@linaro.org>
 <b9a4ea60-28e5-b7aa-0154-ad7481eafbd3@huawei.com>
 <efe01dd1-0f99-dadf-956d-b0e80e1e602c@huawei.com>
To:     Yu Kuai <yukuai3@huawei.com>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 30 mag 2022, alle ore 10:40, Yu Kuai <yukuai3@huawei.com> ha =
scritto:
>=20
> =E5=9C=A8 2022/05/30 16:34, Yu Kuai =E5=86=99=E9=81=93:
>> =E5=9C=A8 2022/05/30 16:10, Paolo Valente =E5=86=99=E9=81=93:
>>>=20
>>>=20
>>>> Il giorno 28 mag 2022, alle ore 11:50, Yu Kuai <yukuai3@huawei.com> =
ha scritto:
>>>>=20
>>>> Currently, bfq can't handle sync io concurrently as long as they
>>>> are not issued from root group. This is because
>>>> 'bfqd->num_groups_with_pending_reqs > 0' is always true in
>>>> bfq_asymmetric_scenario().
>>>>=20
>>>> The way that bfqg is counted into 'num_groups_with_pending_reqs':
>>>>=20
>>>> Before this patch:
>>>> 1) root group will never be counted.
>>>> 2) Count if bfqg or it's child bfqgs have pending requests.
>>>> 3) Don't count if bfqg and it's child bfqgs complete all the =
requests.
>>>>=20
>>>> After this patch:
>>>> 1) root group is counted.
>>>> 2) Count if bfqg have at least one bfqq that is marked busy.
>>>> 3) Don't count if bfqg doesn't have any busy bfqqs.
>>>=20
>>> Unfortunately, I see a last problem here. I see a double change:
>>> (1) a bfqg is now counted only as a function of the state of its =
child
>>>      queues, and not of also its child bfqgs
>>> (2) the state considered for counting a bfqg moves from having =
pending
>>>      requests to having busy queues
>>>=20
>>> I'm ok with with (1), which is a good catch (you are lady explained
>>> the idea to me some time ago IIRC).
>>>=20
>>> Yet I fear that (2) is not ok.  A bfqq can become non busy even if =
it
>>> still has in-flight I/O, i.e.  I/O being served in the drive.  The
>>> weight of such a bfqq must still be considered in the weights_tree,
>>> and the group containing such a queue must still be counted when
>>> checking whether the scenario is asymmetric.  Otherwise service
>>> guarantees are broken.  The reason is that, if a scenario is deemed =
as
>>> symmetric because in-flight I/O is not taken into account, then =
idling
>>> will not be performed to protect some bfqq, and in-flight I/O may
>>> steal bandwidth to that bfqq in an uncontrolled way.
>> Hi, Paolo
>> Thanks for your explanation.
>> My orginal thoughts was using weights_tree insertion/removal, =
however,
>> Jan convinced me that using bfq_add/del_bfqq_busy() is ok.
>> =46rom what I see, when bfqq dispatch the last request,
>> bfq_del_bfqq_busy() will not be called from __bfq_bfqq_expire() if
>> idling is needed, and it will delayed to when such bfqq get scheduled =
as
>> in-service queue again. Which means the weight of such bfqq should =
still
>> be considered in the weights_tree.
>> I also run some tests on null_blk with "irqmode=3D2
>> completion_nsec=3D100000000(100ms) hw_queue_depth=3D1", and tests =
show
>> that service guarantees are still preserved on slow device.
>> Do you this is strong enough to cover your concern?

Unfortunately it is not.  Your very argument is what made be believe
that considering busy queues was enough, in the first place.  But, as
I found out, the problem is caused by the queues that do not enjoy
idling.  With your patch (as well as in my initial version) they are
not counted when they remain without requests queued.  And this makes
asymmetric scenarios be considered erroneously as symmetric.  The
consequence is that idling gets switched off when it had to be kept
on, and control on bandwidth is lost for the victim in-service queues.

Thanks,
Paolo

>> Thanks,
>> Kuai
>>>=20
>>> I verified this also experimentally a few years ago, when I added =
this
>>> weights_tree stuff.  That's the rationale behind the part of
>>> bfq_weights_tree_remove that this patch eliminates.  IOW,
>>> for a bfqq and its parent bfqg to be out of the count for symmetry,
>>> all bfqq's requests must also be completed.
>>>=20
>>> Thanks,
>>> Paolo
>=20
> I forgot to cc Jan for this patchset... This is a reply for Jan.

