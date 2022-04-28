Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F251CC433F5
	for <linux-block@archiver.kernel.org>; Thu, 28 Apr 2022 21:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiD1Vxh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Apr 2022 17:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352814AbiD1VxW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Apr 2022 17:53:22 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A665AC401F
        for <linux-block@vger.kernel.org>; Thu, 28 Apr 2022 14:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651182585; x=1682718585;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cyLVSk6BbZwyGjjwD1EPGCFpNeRSIZ2G598CAEec1yg=;
  b=k90dwTSU1fOL2ncvUVox6xMZjRToW9o665Sx3l0DcHjGV6TaM8Ke6uNQ
   oWsneguZ3I52/cWfSJdYX9lnx/S3UK10mTz+6KktbujOJgSJF+a52dRSN
   8CqrGPZpQ0uWID9Hs8e8Me7KTWc95njDRYxUB5zTogmXxA8bh1Rv+MgFo
   m2p2FeX5DQNp/BiCZy85suEjfsypagg+6lnRLNW46RfH7N96KSQCnIAcu
   avoSCWcxu9wh9Omd51JBLSNnY85iZ4O2ymmryChGy3pzM213SvJBgluXB
   o4H3eOYQ+ms50XpbKZcab2Zg4yDQkKM6DrtQHEZZtlDHGvL98arhN0cpi
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,296,1647273600"; 
   d="scan'208";a="203971438"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2022 05:49:38 +0800
IronPort-SDR: rkvh4zR9e2DJLs32JUQ5qguHzD3LuqSgysSwcREUEvX09Xaah6k51bXPrHSTVSmYAp9wobwzHV
 AhUEMIaE2IADP9wDbEZ10yrJF3TmZeiPboM2R/NFGG6xeu67eEs5DqH22GItkaGb8JTAK7Q/ZU
 N07Vlb2BANvgptm+5MjLWFLSsGDwzGuoZZrLVZhNBEGara5rumfE3uykShheOVPu4xbUURfDoF
 L1yg0i/aQ4KG7vz+ZekKdUD3Pj7YtXkj0pXstIHZqIOMoU2eJ8/X9UQlloze3GiL0XD0VN9Pvw
 OT1XQCebeD+k+CFB8CQRpG8E
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Apr 2022 14:19:48 -0700
IronPort-SDR: ON+E7xlqlTM+c/uQ+zy2vHpuKZpg3jKWrc9EhgTeKsTYKGhsJUrpKj5cBxwYQof1GKBwh5aoV+
 RMcinK6oQ/L2ld3ZR9bw8Jjx08Jc0+w6K0WJPDIE33QTugqTNgJlK0JHGPGf2YaVRk+30icJEV
 53hwGXHGws3MmRmrnwOTdT3qYBK4HZm1SsX3Q2zke3xUHfA0B02wQ6oJqCnayhsEma6qgqnwTb
 hXGzAjNiZgFyQUCZ1cPbiF+AsJTuykeYQFhcG5sfb0igU1TpvnK8iSMdq+WvfOHdY8xd0fhCbK
 vgI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Apr 2022 14:49:40 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Kq8R70z6Xz1SVp4
        for <linux-block@vger.kernel.org>; Thu, 28 Apr 2022 14:49:39 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1651182578; x=1653774579; bh=cyLVSk6BbZwyGjjwD1EPGCFpNeRSIZ2G598
        CAEec1yg=; b=WwDx6zjd5KL3eBUwwa0frNLPJfE5RvQ5zQDMlt1v+brK+CSfEOM
        AwrfKkAoj2MBEg6wPs2KU3cJ8RSuEjUUfxJA/SnSSyFA0auCwS8BShF8Rbde2kZt
        F/4slST/ipXIa+YYgpBZD6WGrhaVTjjKv0mIiW+HQG2XMJl7BpdYBUrEDvL2VHLv
        OVhzsmUWCuQAL8m1VmKZeCeUWiXVI61R1ZfdjxD4e1pIAEdOCsLHVPrXFurRHvrK
        IsiOGhM4lfUwCPBepH8wbdpUuGAD3BpaImFC+lb69DkA3rJxyldi/EA6SbDqlURe
        uqC0i0yoxJWPS5tpYnGwaGc29HA02pISISQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id tA8K2j6dnjLc for <linux-block@vger.kernel.org>;
        Thu, 28 Apr 2022 14:49:38 -0700 (PDT)
Received: from [10.225.163.27] (unknown [10.225.163.27])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kq8R21lmLz1Rvlc;
        Thu, 28 Apr 2022 14:49:34 -0700 (PDT)
Message-ID: <a68a2d40-dff4-bac6-bb05-57c5c88af66e@opensource.wdc.com>
Date:   Fri, 29 Apr 2022 06:49:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 12/16] zonefs: allow non power of 2 zoned devices
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, jaegeuk@kernel.org,
        axboe@kernel.dk, snitzer@kernel.org, hch@lst.de, mcgrof@kernel.org,
        naohiro.aota@wdc.com, sagi@grimberg.me, dsterba@suse.com,
        johannes.thumshirn@wdc.com
Cc:     linux-kernel@vger.kernel.org, clm@fb.com, gost.dev@samsung.com,
        chao@kernel.org, josef@toxicpanda.com, jonathan.derrick@linux.dev,
        agk@redhat.com, kbusch@kernel.org, kch@nvidia.com,
        linux-nvme@lists.infradead.org, bvanassche@acm.org,
        jiangbo.365@bytedance.com, linux-fsdevel@vger.kernel.org,
        matias.bjorling@wdc.com, linux-block@vger.kernel.org
References: <20220427160255.300418-1-p.raghav@samsung.com>
 <CGME20220427160309eucas1p2f677c8db581616f994473f17c4a5bd44@eucas1p2.samsung.com>
 <20220427160255.300418-13-p.raghav@samsung.com>
 <bfc1ddc3-5db3-6879-b6ab-210a00b82c6b@opensource.wdc.com>
 <c490bd45-deab-8c2b-151c-c8db9f97e10c@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <c490bd45-deab-8c2b-151c-c8db9f97e10c@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/29/22 00:54, Pankaj Raghav wrote:
> On 2022-04-28 01:39, Damien Le Moal wrote:
>> On 4/28/22 01:02, Pankaj Raghav wrote:
>>> The zone size shift variable is useful only if the zone sizes are known
>>> to be power of 2. Remove that variable and use generic helpers from
>>> block layer to calculate zone index in zonefs
>>
>> Period missing at the end of the sentence.
>>
> Ack
>> What about zonefs-tools and its test suite ? Is everything still OK on
>> that front ? I suspect not...
>>
> I don't know why you assume that :). Zonefs had only one place that had
> the assumption of po2 zsze sectors:
> if (nr_zones < dev.nr_zones) {
> 	size_t runt_sectors = dev.capacity & (dev.zone_nr_sectors - 1);
> 
> In my local tree I changed it and I was able to run zonefs tests for non
> po2 zone device. I have also mentioned it in my cover letter:
> ```
> ZoneFS:
> zonefs-tests.sh from zonefs-tools were run with no failures.
> ```

This is still not convincing given the code I saw. Additional test cases
need to be added with data verification & concurrent regular writes also
sent while doing copy to verify locking.

Which also reminds me that I have not seen any change to mq-deadline zone
write locking for this series. What is the assumption ? That users should
not be issuing writes when a copy is on-going ? What a bout the reverse
case ? at the very least, it seems that blk_issue_copy() should be taking
the zone write lock.

> I will make sure to add my private tree for zonefs in my cover letter in
> the next rev. But even without that change, a typical emulated npo2
> device should work fine because the changes are applicable only for
> "runt" zones.


-- 
Damien Le Moal
Western Digital Research
