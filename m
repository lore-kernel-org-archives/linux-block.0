Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A35CC433EF
	for <linux-block@archiver.kernel.org>; Wed, 25 May 2022 08:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbiEYIah (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 May 2022 04:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiEYIaf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 May 2022 04:30:35 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4549703F1
        for <linux-block@vger.kernel.org>; Wed, 25 May 2022 01:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653467433; x=1685003433;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=H44rnb6YjTcI7szFqLMfC6IxwjsJO66dk1kVHObyutc=;
  b=n/BG5HaOUkVkYPuCD84XElSUDQ2aW1/eb0Ig7GOTXNe2CSarhEzYcGwN
   AWOPaCYI20SMssTIte2FvC3DD4sFwwjdzJTVGcg9DelbxCBfIPvwkPnYI
   VOMqZy5dTFrq7iPR6qeADxJOOXGuojZRLFxqEUT7v2ecYQIpQS/qo7T5+
   hWLz4RZnp2HJVAGdJlaFFh1VseCdFCHzTb7LTPHz4X3BwGB4IUzPz+wBt
   iFRDO87F3L4XafZHaJM/5O+3CAPrP1nfq0PdBSz13xXyQqtoqhYjz1umZ
   JytSqZaCNyvnTEFLyVDekJMlzf+Xh7Rh9f5Wx/ypbSUC+TnMIe6VdeRJb
   g==;
X-IronPort-AV: E=Sophos;i="5.91,250,1647273600"; 
   d="scan'208";a="313378535"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 May 2022 16:30:29 +0800
IronPort-SDR: swx9AhE0kBOAh7FvnHAyTvLZlilZGr8uzMvDMo4Z0b8StANWPTmz26uDXBUIJDuNOakIodaDgw
 LRpgvy+/UdbeWp1Q4wZCQ5w947OsbSXmuy2FeYdPWn89ZLoGw1TYbancdBaLyn6HO3gQapSW4v
 /6iYmCbbodKI0JL/jVlERXttdKhXZDk26PKL+ZyjUMZgncgv5UaS4oI3Yh16fqfuz0k0ZnemAj
 wDY0DAdjGT4GngkLPUf1pwVhKLljOMVxg9+0f57L+zCt9I/eZXiXyTlhOXvhfrWbUNpuxzTv6/
 ZE8y7f6hRZRXqFNFWQqiqaEx
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 May 2022 00:54:25 -0700
IronPort-SDR: 9+bXI/uOmzgtg9EeFQ0T4+XHsNn9DPn0qzd5SMPyDqGn0dJ0dQQbMbZG4T4VleI/uK/WWPvhxj
 JDn4C+8r8UV3HAKkut5ppPjVHAiU0sRBU42/mYXeA5fgIqyrzJ9KV8HQKTE+8C9zLeQbI7sADB
 1otFXlNPFpWGYJs2R9wMbMUd4Iqr7G5Tne8zzkfsm9/kJGu1/cjGp8MJ0SuO2Wzq7DElCXpEzi
 doMC8P5xctcFCNkXPfdTJaDbHGThVMvCA7voGYWPhh+S6rLBnQvu1iQ9tMVH1s84q4AW3C5iPy
 9QY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 May 2022 01:30:29 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L7PQX6wDqz1SVnx
        for <linux-block@vger.kernel.org>; Wed, 25 May 2022 01:30:28 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1653467428; x=1656059429; bh=H44rnb6YjTcI7szFqLMfC6IxwjsJO66dk1k
        VHObyutc=; b=bn27ZGKuraDKiwB8/YNJvW122+IQPqXQOWpULKKkzZcQIRW/pnB
        25SuhXuAnXEL0ysxU5z3kz0lbOAt+hF3AytSc9/BJSBqnE7DbqrkPSZEzfth2YAI
        A36dLXoa88AXlSbVBkFdS4usRHBZ4Gq+iImPq3JU46h2F5NllfeT8vIqMnQncsWd
        FDw/TEsQTRk4y3BRkxiLaU6TNMb38do3adtYkRkn440RpQ9lHFLsqIUclyu15WB+
        Z5JawCBv+WfTX2i4OTQsVKD4yzvJEIJJhk6yhtKiU5QfTRH4nPyZPOrPDW9hCMAA
        7sJSoMk0ZETbGEOyZoGTuWhIIw2/S1SY5qw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4jqc2qRHGOG4 for <linux-block@vger.kernel.org>;
        Wed, 25 May 2022 01:30:28 -0700 (PDT)
Received: from [10.225.163.54] (unknown [10.225.163.54])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L7PQV3B7Nz1Rvlc;
        Wed, 25 May 2022 01:30:26 -0700 (PDT)
Message-ID: <f3ab71c9-26b2-d4f1-5340-78a82ef90c0e@opensource.wdc.com>
Date:   Wed, 25 May 2022 17:30:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCHv3 1/6] block/bio: remove duplicate append pages code
Content-Language: en-US
To:     Pankaj Raghav <pankydev8@gmail.com>,
        Keith Busch <kbusch@kernel.org>
Cc:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, axboe@kernel.dk,
        Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, ebiggers@kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>
References: <20220523210119.2500150-1-kbusch@fb.com>
 <20220523210119.2500150-2-kbusch@fb.com>
 <20220524141754.msmt6s4spm4istsb@quentin>
 <Yoz7+O2CAQTNfvlV@kbusch-mbp.dhcp.thefacebook.com>
 <20220525074941.2biavbbrjdjcnlsd@quentin>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220525074941.2biavbbrjdjcnlsd@quentin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/25/22 16:49, Pankaj Raghav wrote:
> On Tue, May 24, 2022 at 09:38:32AM -0600, Keith Busch wrote:
>> On Tue, May 24, 2022 at 04:17:54PM +0200, Pankaj Raghav wrote:
>>> On Mon, May 23, 2022 at 02:01:14PM -0700, Keith Busch wrote:
>>>> -	if (WARN_ON_ONCE(!max_append_sectors))
>>>> -		return 0;
>>> I don't see this check in the append path. Should it be added in
>>> bio_iov_add_zone_append_page() function?
>>
>> I'm not sure this check makes a lot of sense. If it just returns 0 here, then
>> won't that get bio_iov_iter_get_pages() stuck in an infinite loop? The bio
>> isn't filling, the iov isn't advancing, and 0 indicates keep-going.
> Yeah but if max_append_sectors is zero, then bio_add_hw_page() also
> returns 0 as follows:
> ....
> 	if (((bio->bi_iter.bi_size + len) >> 9) > max_sectors)
> 		return 0;
> ....
> With WARN_ON_ONCE, we at least get a warning message if it gets stuck in an
> infinite loop because of max_append_sectors being zero right?
> 

Warning about an infinite loop that can be recovered from only by
rebooting the machine is not very useful...
If max_append_sectors is zero and bio_iov_add_zone_append_page() is
called, this is an error (stupid user) and everything should be failed
with -ENOSUPP or -EIO.

-- 
Damien Le Moal
Western Digital Research
