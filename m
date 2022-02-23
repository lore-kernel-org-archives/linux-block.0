Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C6EC433F5
	for <linux-block@archiver.kernel.org>; Wed, 23 Feb 2022 07:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiBWHrP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Feb 2022 02:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiBWHrN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Feb 2022 02:47:13 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A0A31920
        for <linux-block@vger.kernel.org>; Tue, 22 Feb 2022 23:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645602405; x=1677138405;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=jBm3zlBXQd9XPafj6TCjNXZA67TY72YXB4jio1jRjxA=;
  b=G2dXVqLdDbgyrfDmW9pjnF/B2uKfqtsuF10qRgDX2id/yozcQv48DhuB
   EWCJKX0dBTydLDvxRdOBS7vMeUfYQoY+xBByowsh4CW7qYwXfOpm6yhI3
   EaMjvgLvGVHd51R2vqDACPvtp+eNafxnTVXwJsGt98WLmaMPcl0iIQUYw
   2XZt52MS9DZWnSIM9mcCrldgRXDvtB2OjBP1kAI71Oz1X2QGy9LdeOkD4
   lrCTOkBG0PlolW3q8G8xRqHnUJrglX85CjDM1hZVBsMizBroMsMfmrHrt
   YzkSYSIfsF3zo+DLjqRrC3+SiXthjAkYgybeXQY6i1/iOlr+wIRty7NxT
   A==;
X-IronPort-AV: E=Sophos;i="5.88,390,1635177600"; 
   d="scan'208";a="305643782"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Feb 2022 15:46:44 +0800
IronPort-SDR: aZlrh1sXWNGDVhOZcyhwgq3Wok8QaWeH+DjFiKsRhhgq3pi/yvZ9R9H/LM00HFhVjD+yl/0l8G
 OwwZ8a3RNyf/LZtMbdI+BVaHHPwNbwQZiaDxgYTOga9bh0Woqk3baTUdMelhCJQK5K/KyiQkyq
 X0Y/sn2ssophC6+JEr3lCJZtLqwC92vv60d9ZACaKfa4CBMhyM2c5wDsxCZgd7ksvsLMqbhJ8C
 1/dP58uKy8UlXB5MKv5yKBDdRnxIHDmjLYN70iXHuT/KI93yONEEx0VzGysJG3G6DmaFX9UyE1
 wyP8fcHthjmoG+TEF/g270Mq
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 23:19:22 -0800
IronPort-SDR: LsEm6DbElChEHI6mYuLQnrEieZW6N3M9yCPGlTzbjs2Xq9KUfyEKBiUrzdN0lWM9rsx+xwNY4y
 9Ej0nqPLZvg2xSocn/eCs3oR/gFEL8ImJ4mwIVQTOUOZ1FDk2VncbocSHbDV28173WeO2qMwNI
 Uto6zRErwOMBUG7jw9+d0bLmj6hQubCxTOa9Ma5sNnrbWFRIoR44qLJtgEnjt4CjXEXUTBvEvr
 zFUWl/glS2PVfw4Pw0Pjga73IwKu3lwd3Cj2u0vgeQzNTJ5SyotNgMHwzNyV3ZVTRXeZzeXLTK
 rdA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 23:46:45 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4K3Sm442bdz1SHwl
        for <linux-block@vger.kernel.org>; Tue, 22 Feb 2022 23:46:44 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1645602404; x=1648194405; bh=jBm3zlBXQd9XPafj6TCjNXZA67TY72YXB4j
        io1jRjxA=; b=tpKGEL82o93a2D64X5Ip+9A3IqKq2B+i4MOzIhI1sISvKV/9nha
        mosnJC3Jqn24/GiCnAFuQde5hC2XZwDP4ZMOtg8+IzbQygX5+5LUKxPMttJ37dst
        k15rSQac9v9d7Ja9I47B+1yaM8kWFRyf2VlEZOKHkeBCUEqDy7wlwhLN9de8gJyy
        PGRKssVU5k6Yf+l2qP1KMCkHodFcD9L94HJhSh6hAfLKJ602s0kS/aGKVOF4QFx+
        7DPzczSLa6CY34i4fH3UxRhKT5+9ew5++uSN4UToO1ONyeWmiqDrkAMFiu0dF9Cf
        0p0fC2Q1eHhTbWMSXzHDuzqvSNtAzAHGtIQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4wa1C7QT-fI4 for <linux-block@vger.kernel.org>;
        Tue, 22 Feb 2022 23:46:44 -0800 (PST)
Received: from [10.225.163.81] (unknown [10.225.163.81])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4K3Sm33LwKz1Rvlx;
        Tue, 22 Feb 2022 23:46:43 -0800 (PST)
Message-ID: <a55211a1-a610-3d86-e21a-98751f20f21e@opensource.wdc.com>
Date:   Wed, 23 Feb 2022 16:46:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [LSF/MM/BPF TOPIC] block drivers in user space
Content-Language: en-US
To:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org
References: <YhXMu/GcceyDx637@B-P7TQMD6M-0146.local>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <YhXMu/GcceyDx637@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/23/22 14:57, Gao Xiang wrote:
> On Mon, Feb 21, 2022 at 02:59:48PM -0500, Gabriel Krisman Bertazi wrote:
>> I'd like to discuss an interface to implement user space block devices,
>> while avoiding local network NBD solutions.  There has been reiterated
>> interest in the topic, both from researchers [1] and from the community,
>> including a proposed session in LSFMM2018 [2] (though I don't think it
>> happened).
>>
>> I've been working on top of the Google iblock implementation to find
>> something upstreamable and would like to present my design and gather
>> feedback on some points, in particular zero-copy and overall user space
>> interface.
>>
>> The design I'm pending towards uses special fds opened by the driver to
>> transfer data to/from the block driver, preferably through direct
>> splicing as much as possible, to keep data only in kernel space.  This
>> is because, in my use case, the driver usually only manipulates
>> metadata, while data is forwarded directly through the network, or
>> similar. It would be neat if we can leverage the existing
>> splice/copy_file_range syscalls such that we don't ever need to bring
>> disk data to user space, if we can avoid it.  I've also experimented
>> with regular pipes, But I found no way around keeping a lot of pipes
>> opened, one for each possible command 'slot'.
>>
>> [1] https://dl.acm.org/doi/10.1145/3456727.3463768
>> [2] https://www.spinics.net/lists/linux-fsdevel/msg120674.html
> 
> I'm interested in this general topic too. One of our use cases is
> that we need to process network data in some degree since many
> protocols are application layer protocols so it seems more reasonable
> to process such protocols in userspace. And another difference is that
> we may have thousands of devices in a machine since we'd better to run
> containers as many as possible so the block device solution seems
> suboptimal to us. Yet I'm still interested in this topic to get more
> ideas.
> 
> Btw, As for general userspace block device solutions, IMHO, there could
> be some deadlock issues out of direct reclaim, writeback, and userspace
> implementation due to writeback user requests can be tripped back to
> the kernel side (even the dependency crosses threads). I think they are
> somewhat hard to fix with user block device solutions. For example,
> https://lore.kernel.org/r/CAM1OiDPxh0B1sXkyGCSTEpdgDd196-ftzLE-ocnM8Jd2F9w7AA@mail.gmail.com

This is already fixed with prctl() support. See:

https://lore.kernel.org/linux-fsdevel/20191112001900.9206-1-mchristi@redhat.com/


-- 
Damien Le Moal
Western Digital Research
