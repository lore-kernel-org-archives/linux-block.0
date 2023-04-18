Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E094AC6FD18
	for <linux-block@archiver.kernel.org>; Tue, 18 Apr 2023 14:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjDROFZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Apr 2023 10:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjDROFZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Apr 2023 10:05:25 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3AF12CB0
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 07:05:23 -0700 (PDT)
Received: from canpemm100004.china.huawei.com (unknown [7.192.105.92])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Q15JQ4yVHz8x4N;
        Tue, 18 Apr 2023 22:04:22 +0800 (CST)
Received: from [10.174.179.14] (10.174.179.14) by
 canpemm100004.china.huawei.com (7.192.105.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 18 Apr 2023 22:05:12 +0800
Subject: Re: How best to get the size of a blockdev from a file?
To:     Kanchan Joshi <joshi.k@samsung.com>,
        David Howells <dhowells@redhat.com>
CC:     <hch@lst.de>, <linux-block@vger.kernel.org>
References: <CGME20230418100108epcas5p2d0f2a7a274e78731373986b3d4fced9b@epcas5p2.samsung.com>
 <1609851.1681812012@warthog.procyon.org.uk> <20230418122833.GA14457@green245>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <e4f7df06-ccba-700b-5a69-ea44bd54e672@huawei.com>
Date:   Tue, 18 Apr 2023 22:05:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20230418122833.GA14457@green245>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.14]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm100004.china.huawei.com (7.192.105.92)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2023/4/18 20:28, Kanchan Joshi wrote:
> On Tue, Apr 18, 2023 at 11:00:12AM +0100, David Howells wrote:
>> Hi Christoph,
>>
>> It seems that my use of i_size_read(file_inode(in)) in 
>> filemap_splice_read()
>> to get the size of the file to be spliced from doesn't work in the 
>> case of
>> blockdevs and it always returns 0.
>>
>> What would be the best way to get the blockdev size?  Look at
>> file->f_mapping->i_size maybe?
> 
> bdev_nr_bytes(I_BDEV(file->f_mapping->host))
> should work I suppose.
> 

This needs the caller to check if the file is a blockdev. Can we fill 
the upper inode size which belongs to devtmpfs so that the generic code 
do not need to aware the low level inode type?
