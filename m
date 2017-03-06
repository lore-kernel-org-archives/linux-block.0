Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51548 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754072AbdCFVzZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 6 Mar 2017 16:55:25 -0500
Subject: Re: [PATCH] zram: set physical queue limits to avoid array out of
 bounds accesses
To: Andrew Morton <akpm@linux-foundation.org>
References: <20170306102335.9180-1-jthumshirn@suse.de>
 <96ed9003-6299-b303-a901-d040a8cfe03f@fb.com>
 <20170306121840.aaa0525d3dbdeb82aad3c284@linux-foundation.org>
CC: Johannes Thumshirn <jthumshirn@suse.de>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Christoph Hellwig <hch@lst.de>,
        "Sergey Senozhatsky" <sergey.senozhatsky.work@gmail.com>,
        Hannes Reinecke <hare@suse.de>, <yizhan@redhat.com>,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
From: Jens Axboe <axboe@fb.com>
Message-ID: <bffdf6fc-becb-32c7-2669-fb18ebc3e172@fb.com>
Date: Mon, 6 Mar 2017 13:19:56 -0700
MIME-Version: 1.0
In-Reply-To: <20170306121840.aaa0525d3dbdeb82aad3c284@linux-foundation.org>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 03/06/2017 01:18 PM, Andrew Morton wrote:
> On Mon, 6 Mar 2017 08:21:11 -0700 Jens Axboe <axboe@fb.com> wrote:
> 
>> On 03/06/2017 03:23 AM, Johannes Thumshirn wrote:
>>> zram can handle at most SECTORS_PER_PAGE sectors in a bio's bvec. When using
>>> the NVMe over Fabrics loopback target which potentially sends a huge bulk of
>>> pages attached to the bio's bvec this results in a kernel panic because of
>>> array out of bounds accesses in zram_decompress_page().
>>
>> Applied, thanks.
> 
> With an added cc:stable, hopefully?

I didn't. But I can email it to stable@ when it lands in Linus's tree.

-- 
Jens Axboe
