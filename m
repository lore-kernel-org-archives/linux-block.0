Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95818C433F5
	for <linux-block@archiver.kernel.org>; Mon, 28 Mar 2022 05:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236913AbiC1F5B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Mar 2022 01:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbiC1F47 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Mar 2022 01:56:59 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBCCFD3E
        for <linux-block@vger.kernel.org>; Sun, 27 Mar 2022 22:55:16 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220328055510epoutp0349335a53cace097fba1bc42884fae111~gdbsvadGk2106921069epoutp03e
        for <linux-block@vger.kernel.org>; Mon, 28 Mar 2022 05:55:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220328055510epoutp0349335a53cace097fba1bc42884fae111~gdbsvadGk2106921069epoutp03e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648446910;
        bh=T6whiRjWfdN1vlsHlKJrbgN1KF63tkFQ6NOjc/voY84=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FUch3g/mfXZh/ZxCAje6vs5UdbaPZHrY8JXrSB1Gvq5ibIpPKUeLak/6gEInwK/qr
         aWBBTvhT+Dg+YkAQTCUiVdH0Nb76jj4AkKFoZXE+WsAb7poHaHfrR7tb3U9z4GZGI6
         o6VeDg4cE+Ju+205Nrf6foI4Cue2dDeVZy/cCop0=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220328055509epcas5p4b6a5da7339afb101f2278d0e08019708~gdbsTcC3H1059210592epcas5p4G;
        Mon, 28 Mar 2022 05:55:09 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4KRhjz6CfCz4x9QK; Mon, 28 Mar
        2022 05:55:03 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4D.90.05590.6BD41426; Mon, 28 Mar 2022 14:55:02 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220328055221epcas5p2b89350b832172fd7f030de4740902000~gdZPsJx_V0935809358epcas5p2Y;
        Mon, 28 Mar 2022 05:52:21 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220328055221epsmtrp18314df2398e43e021bd1e0b7de026d0f~gdZPrU4Bb2830328303epsmtrp1T;
        Mon, 28 Mar 2022 05:52:21 +0000 (GMT)
X-AuditID: b6c32a4b-739ff700000015d6-24-62414db6fd75
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        AC.88.03370.51D41426; Mon, 28 Mar 2022 14:52:21 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220328055220epsmtip191ee9a4a7f3726f8455e5a17a3dfe1a8~gdZOUA_571711217112epsmtip1Z;
        Mon, 28 Mar 2022 05:52:20 +0000 (GMT)
Date:   Mon, 28 Mar 2022 11:17:17 +0530
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Hannes Reinecke <hare@suse.de>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        linux-mm@kvack.org
Subject: Re: [LSF/MM/BPF TOPIC] block drivers in user space
Message-ID: <20220328054717.GA16252@test-zns>
MIME-Version: 1.0
In-Reply-To: <YkCSVSk1SwvtABIW@T590>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEJsWRmVeSWpSXmKPExsWy7bCmpu42X8ckg7n3zSz2LJrEZLHo6HUW
        i723tC3urfnParHv9V5mi0OTm5ksNv09yeTA7rHj7hJGj02fJrF77Hxo6TH5xnJGj/f7rrJ5
        bD5d7fF5k1wAe1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotP
        gK5bZg7QNUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScApMCveLE3OLSvHS9vNQS
        K0MDAyNToMKE7Iy/M/8xF2yRq3g0s529gXGNZBcjJ4eEgIlEY8Ny9i5GLg4hgd2MEtt3LWUF
        SQgJfGKU2HhEECLxmVHixt6pLDAdf05PYIZI7GKUWDh3GyuE84xRYuKsc+wgVSwCqhI/r09l
        6mLk4GAT0JS4MLkUJCwioCRx9+5qsHXMAg8YJXbsmwS2TljAWuLPpC9gNq+ArsT+hv9MELag
        xMmZT8A2cwqoSBw5MIkNxBYVUJY4sO04E8ggCYFeDompZ58yQpznInHiQjuULSzx6vgWdghb
        SuJlfxuUnSzRuv0yO8hxEgIlEksWqEOE7SUu7vkLtpdZIENi0YwXzBBxWYmpp9ZBxfkken8/
        YYKI80rsmAdjK0rcm/SUFcIWl3g4YwmU7SExddEHaPieZJT4dnMhywRG+VlIfpuFZB+EbSXR
        +aGJdRbQecwC0hLL/3FAmJoS63fpL2BkXcUomVpQnJueWmxaYJyXWg6P8OT83E2M4MSq5b2D
        8dGDD3qHGJk4GA8xSnAwK4nwyp61TxLiTUmsrEotyo8vKs1JLT7EaAqMq4nMUqLJ+cDUnlcS
        b2hiaWBiZmZmYmlsZqgkznsqfUOikEB6YklqdmpqQWoRTB8TB6dUA1P5rO6OgnsMl1w4N8lN
        Tr0kL3dUp+3g1zSe20suyitOqne+4xiRKMjrpH/BU/J0VU/l6hK2i/Gf9l484Gq+SkRYpl6g
        QkC0quK7ktDthJWhWY6OHj81s217D11cqygX/tvw2+Lwr+rRuw82bXHSmrjxxE7u2m+hOl6x
        j5jdvPxvSrWFfr2kGX7njNq088JuU7rEV6zUOc3xx7xJr/o317byV8aM6+5ZzX7btqCXc93n
        OKW0oAPN15/uNRS8vqPy3He977v8ni/79kn64BkGmZAHzlLfLQ2VPq7+aaDkEZVv0KVR4Mvw
        Rdju/16mxJO2y6UmiFy5vHRz/2tBrgy9pde/Xb8TPuNUZNbKDyFBL5RYijMSDbWYi4oTAeiP
        hAA1BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsWy7bCSnK6or2OSQc9+LYs9iyYxWSw6ep3F
        Yu8tbYt7a/6zWux7vZfZ4tDkZiaLTX9PMjmwe+y4u4TRY9OnSeweOx9aeky+sZzR4/2+q2we
        m09Xe3zeJBfAHsVlk5Kak1mWWqRvl8CVsWviFraCZ9IV2y5tZGlg/CHWxcjJISFgIvHn9ATm
        LkYuDiGBHYwS+7s6WCES4hLN136wQ9jCEiv/PWeHKHrCKLHx8gVmkASLgKrEz+tTmboYOTjY
        BDQlLkwuBQmLCChJ3L27GqyeWeARo8TZN4uYQBLCAtYSfyZ9AVvAK6Arsb/hPxPE0JOMEitP
        72SGSAhKnJz5hAXEZhYwk5i3+SEzyAJmAWmJ5f84QMKcAioSRw5MYgOxRQWUJQ5sO840gVFw
        FpLuWUi6ZyF0L2BkXsUomVpQnJueW2xYYJSXWq5XnJhbXJqXrpecn7uJERwTWlo7GPes+qB3
        iJGJg/EQowQHs5IIr+xZ+yQh3pTEyqrUovz4otKc1OJDjNIcLErivBe6TsYLCaQnlqRmp6YW
        pBbBZJk4OKUamErj8r62He46rNOTzFfQkJ7x/e/OzgkTfbruuTzXPnT26GpmpccNDz0XmCVG
        B0WeDjsSf+7QvwLXr+X/HK8d3Lhp+p78e5ybOPZuLzu7N/BN64ZJ8+9urVyZd527x+u02W3T
        ndNKBXftfGLiGXpJUtnSuaetnPHM95JLdw4udPqtvGbpcq72A16R9gbTw+P8pr9NLN1zzDj+
        Zd65X6Jah+3leiQTjhUb+dmm//hz6dDhTxJ7M4z778pz6k3YOm2KpW147lLObqO9P3meCXz0
        yZy8r8Jr5UIp3U/t51If/XsU0zBxfQFbU3n71c7LczaZmUfPTr2ZmHW7fHtm8EcttpbeFonF
        kpmZJsU1EtM7NZVYijMSDbWYi4oTASNRkZz4AgAA
X-CMS-MailID: 20220328055221epcas5p2b89350b832172fd7f030de4740902000
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----9xePhvBs7L.CmQYP2EuM5i8QaKGj7GHgcW4toGXxqW8MJ5yL=_10a20_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220327163555epcas5p430d58efe9dd4e5bb2db31da74b15182b
References: <87tucsf0sr.fsf@collabora.com>
        <986caf55-65d1-0755-383b-73834ec04967@suse.de>
        <CGME20220327163555epcas5p430d58efe9dd4e5bb2db31da74b15182b@epcas5p4.samsung.com>
        <YkCSVSk1SwvtABIW@T590>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

------9xePhvBs7L.CmQYP2EuM5i8QaKGj7GHgcW4toGXxqW8MJ5yL=_10a20_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Mon, Mar 28, 2022 at 12:35:33AM +0800, Ming Lei wrote:
>On Tue, Feb 22, 2022 at 07:57:27AM +0100, Hannes Reinecke wrote:
>> On 2/21/22 20:59, Gabriel Krisman Bertazi wrote:
>> > I'd like to discuss an interface to implement user space block devices,
>> > while avoiding local network NBD solutions.  There has been reiterated
>> > interest in the topic, both from researchers [1] and from the community,
>> > including a proposed session in LSFMM2018 [2] (though I don't think it
>> > happened).
>> >
>> > I've been working on top of the Google iblock implementation to find
>> > something upstreamable and would like to present my design and gather
>> > feedback on some points, in particular zero-copy and overall user space
>> > interface.
>> >
>> > The design I'm pending towards uses special fds opened by the driver to
>> > transfer data to/from the block driver, preferably through direct
>> > splicing as much as possible, to keep data only in kernel space.  This
>> > is because, in my use case, the driver usually only manipulates
>> > metadata, while data is forwarded directly through the network, or
>> > similar. It would be neat if we can leverage the existing
>> > splice/copy_file_range syscalls such that we don't ever need to bring
>> > disk data to user space, if we can avoid it.  I've also experimented
>> > with regular pipes, But I found no way around keeping a lot of pipes
>> > opened, one for each possible command 'slot'.
>> >
>> > [1] https://protect2.fireeye.com/v1/url?k=894d9ec4-e83076bc-894c158b-74fe485fffb1-3de06c94a9e9abfa&q=1&e=40f886a9-b53a-42b0-8e68-c94bc3813a9c&u=https%3A%2F%2Fdl.acm.org%2Fdoi%2F10.1145%2F3456727.3463768
>> > [2] https://www.spinics.net/lists/linux-fsdevel/msg120674.html
>> >
>> Actually, I'd rather have something like an 'inverse io_uring', where an
>> application creates a memory region separated into several 'ring' for
>> submission and completion.
>> Then the kernel could write/map the incoming data onto the rings, and
>> application can read from there.
>> Maybe it'll be worthwhile to look at virtio here.
>
>IMO it needn't 'inverse io_uring', the normal io_uring SQE/CQE model
>does cover this case, the userspace part can submit SQEs beforehand
>for getting notification of each incoming io request from kernel driver,
>then after one io request is queued to the driver, the driver can
>queue a CQE for the previous submitted SQE. Recent posted patch of
>IORING_OP_URING_CMD[1] is perfect for such purpose.
I had added that as one of the potential usecases to discuss for
uring-cmd:
https://lore.kernel.org/linux-block/20220228092511.458285-1-joshi.k@samsung.com/
And your email is already bringing lot of clarity on this.

>I have written one such userspace block driver recently, and [2] is the
>kernel part blk-mq driver(ubd driver), the userspace part is ubdsrv[3].
>Both the two parts look quite simple, but still in very early stage, so
>far only ubd-loop and ubd-null targets are implemented in [3]. Not only
>the io command communication channel is done via IORING_OP_URING_CMD, but
>also IO handling for ubd-loop is implemented via plain io_uring too.
>
>It is basically working, for ubd-loop, not see regression in 'xfstests -g auto'
>on the ubd block device compared with same xfstests on underlying disk, and
>my simple performance test on VM shows the result isn't worse than kernel loop
>driver with dio, or even much better on some test situations.
Added this in my to-be-read list. Thanks for sharing.




------9xePhvBs7L.CmQYP2EuM5i8QaKGj7GHgcW4toGXxqW8MJ5yL=_10a20_
Content-Type: text/plain; charset="utf-8"


------9xePhvBs7L.CmQYP2EuM5i8QaKGj7GHgcW4toGXxqW8MJ5yL=_10a20_--
