Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F34CC433EF
	for <linux-block@archiver.kernel.org>; Fri, 22 Jul 2022 06:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbiGVGMU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Jul 2022 02:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233975AbiGVGMS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jul 2022 02:12:18 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203CC97D48
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 23:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658470331; x=1690006331;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9VvUaGB19Q2RfjOMcnmhe65B34xEhqMPYGnsRxq86zs=;
  b=bJ9r10KVS5PbXrQAIcCxmYqI188GpEScQZiPSmZl58q9oSMXC47R+0TY
   UPKUehshQ0g6PEnQTvfK3tGbMzkeqkL4DeJvUPnB1xLGGDUq+FJIXklcW
   sJqAVmUwQGKPtELypq2DNhTDWXUMoNgqRDHOeWsGqlIhImbL9992R85lE
   trf5RCIwWyaos742Yurs3mBXo5YUX26oyc9Hu0+80tfQo2aaKlnwA0a+I
   rhMIS60NRCNpq3KYsPVTQYxRxqDNp0zXeta6A9O/6LP74MNkJXReZ0Wj0
   Jiq3+WvsM+7GFiea8/Is7o5SxawsGzd2LQ1lyifqaFuWAKEjMdzJGrsof
   g==;
X-IronPort-AV: E=Sophos;i="5.93,184,1654531200"; 
   d="scan'208";a="211569334"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jul 2022 14:12:10 +0800
IronPort-SDR: ewJ6CcVdx9EScclBWHvEcQKmlnoaCCFSEFF0w3zv2D7iDitsE46BwjNe09uRqCSn1TcYWSysQM
 QVuVJ19juo+yjRhL5+cYp8RAH5x5aRPqNXBi7BfZRmnIoBpCXTESLohJf84ebSd01FGdimPQol
 p6w6ewnVhCugORGZCJ9xqfvYP0qomD82drwJFMYYhihUzipOm1sRCW8qbS9qW9h5v9HZeeV4F7
 92qZuXLbOrjLAlV8Kcl09rX07EYodYaWulJK7cYXdkv5OYGp7hYKHQmJw3Y1hmU3FjGaU6YTV9
 5AtrchtneFD2stsJRd/KYH5u
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Jul 2022 22:33:28 -0700
IronPort-SDR: UDJQHhVuROEjQT1DgmjyZXeMJYu4jCOerVuUoDP3WVJxzsAvMuRGse1/bBgpM4L58FMkzM8zy+
 AOtvimnRoZdnPtE5CvwKa5DQldS8s7KQKXuxqa1xi9kipXe9BZtvoefCA6ODMJ8oB5XO9Uhwdc
 ewI7WoF+4ZnlVKks3HSqtroGgFyWEpyw7wSsAJaJDY+SAk9WTIicuGEDwH5FasVadnNMQGOHmq
 Tbfc5+psG92UgSuHdSVwxJIsuZx2W85qA16iTFiyTCru9xsOoNQsQbAUjabrFAGPyRT2GFdY3S
 Tag=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Jul 2022 23:12:12 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LpzcB594Rz1Rw4L
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 23:12:10 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1658470330; x=1661062331; bh=9VvUaGB19Q2RfjOMcnmhe65B34xEhqMPYGn
        sRxq86zs=; b=RqWwQeCh5VzO3GnGY2MTZ/vxn7b3XLdrJnL7nhW6aDvkYXUDh4Z
        9wFYgzknwOM6ZGWOFlJPndqfdHASSXnYZ5PtCdePlddgCkOLrkA0G5636Pot1N+n
        0oa77uqxO8vv+QAj7irFKIfw8ocgP6qtwD9CfCQUBx7dtAY6oUXALAj7SwafVwsO
        8xZAsFCjrygiAF308+JGEnyHROKvnezeVjGtv+8O2IzkI3tkhyrx/wX3KIopphFT
        IjcuizEaZ7wDmzD3ltGPyZk4GOj9y9SoM7pyyYFq+gcfDrrkGlrN7gP1paZlex/Z
        6fjVeIKcDyFvEJ7kSo/2yN5DdqydW14YuJw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id c-zV8RhrVvGk for <linux-block@vger.kernel.org>;
        Thu, 21 Jul 2022 23:12:10 -0700 (PDT)
Received: from [10.225.163.125] (unknown [10.225.163.125])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Lpzc96QNsz1RtVk;
        Thu, 21 Jul 2022 23:12:09 -0700 (PDT)
Message-ID: <9540da35-8256-a24d-238f-434c6a86592a@opensource.wdc.com>
Date:   Fri, 22 Jul 2022 15:12:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/5] block: move the call to get_max_io_size out of
 blk_bio_segment_split
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20220720142456.1414262-1-hch@lst.de>
 <20220720142456.1414262-4-hch@lst.de>
 <133b4a85-7106-8cb0-94da-842d7744e19c@opensource.wdc.com>
 <20220722061117.GA31570@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220722061117.GA31570@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/22/22 15:11, Christoph Hellwig wrote:
> On Fri, Jul 22, 2022 at 03:09:57PM +0900, Damien Le Moal wrote:
>> On 7/20/22 23:24, Christoph Hellwig wrote:
>>> Prepare for reusing blk_bio_segment_split for (file system controlled)
>>> splits of REQ_OP_ZONE_APPEND bios by letting the caller control the
>>> maximum size of the bio.
>>>
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>
>> Looks good. Though I think this patch could wait for the actual users of
>> this change.
> 
> I don't think passing an additional argument is in any way harmful
> even now, and I'd like to reduce the cross-tree dependencies for
> the next cycle.  With this series in I just need to an an export
> in the btrfs series, which would be great.

Works for me !


-- 
Damien Le Moal
Western Digital Research
