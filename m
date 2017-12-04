Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.cn.fujitsu.com ([183.91.158.132]:36099 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752431AbdLDJsi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Dec 2017 04:48:38 -0500
Message-ID: <5A2519F4.5040102@cn.fujitsu.com>
Date: Mon, 4 Dec 2017 17:48:36 +0800
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
To: Eryu Guan <eguan@redhat.com>
CC: <fstests@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>,
        <linux-block@vger.kernel.org>
Subject: Re: [PATCH] generic/473: test return EBUSY from BLKRRPART for mounted
 whole-dev
References: <1511956946-16667-1-git-send-email-yangx.jy@cn.fujitsu.com> <20171204082923.GF2749@eguan.usersys.redhat.com> <5A251225.7080905@cn.fujitsu.com> <20171204092558.GH2749@eguan.usersys.redhat.com>
In-Reply-To: <20171204092558.GH2749@eguan.usersys.redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 2017/12/04 17:25, Eryu Guan wrote:
> On Mon, Dec 04, 2017 at 05:15:17PM +0800, Xiao Yang wrote:
>> On 2017/12/04 16:29, Eryu Guan wrote:
>>> On Wed, Nov 29, 2017 at 08:02:26PM +0800, Xiao Yang wrote:
>>>> If the entire block device is formatted with a filesystem and
>>>> mounted, running "blockdev --rereadpt" should fail and return
>>>> EBUSY instead of pass.
>>>>
>>>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>>> As we have blktests[1] now, I think this may fit in blktests better?
>> Hi Eryu,
>>
>> Do you think test cases which use scsi_debug module should be moved into
>> blktests?
>> (e.g. generic/108, generic/349, generic/350, generic/351)
> I don't think they need to be moved to blktests. Most other tests that
> take use of scsi_debug are for filesystem testing, e.g. generic/108.
> generic/349 generic/35[01] are a bit special, they were there before
> blktests was announced available, so they're in a special blockdev group
> and not in the auto group. If Omar agrees, I think they can be ported to
> blktests.
Hi Eryu,

Thanks for your explanation, and i will try to send it to blktests.

Thanks,
Xiao Yang
> Thanks,
> Eryu
>
>
>
