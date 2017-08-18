Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59407 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750881AbdHRIMy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Aug 2017 04:12:54 -0400
Subject: Re: [PATCH 1/2] loop: always return block size in LOOP_GET_STATUS
To: Omar Sandoval <osandov@osandov.com>, Karel Zak <kzak@redhat.com>
Cc: linux-block@vger.kernel.org, kernel-team@fb.com,
        Ming Lei <ming.lei@redhat.com>
References: <cover.1503036471.git.osandov@fb.com>
 <9ff9b291e3e872698a040a281549c39c0637565f.1503036471.git.osandov@fb.com>
 <c54bc65f-7106-0dee-77dc-32bbaf1a3d1d@suse.de> <20170818073838.GG2459@vader>
 <3f01f907-0443-4961-d4fd-a5a3ffe8e688@suse.de> <20170818074700.GH2459@vader>
 <d5d61484-9aa9-5161-8abf-cce924521df1@suse.de> <20170818080539.GI2459@vader>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <3a42bb8d-1850-8d6c-11c6-bf8632af5e7a@suse.de>
Date: Fri, 18 Aug 2017 10:12:51 +0200
MIME-Version: 1.0
In-Reply-To: <20170818080539.GI2459@vader>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 08/18/2017 10:05 AM, Omar Sandoval wrote:
> On Fri, Aug 18, 2017 at 09:56:26AM +0200, Hannes Reinecke wrote:
>> On 08/18/2017 09:47 AM, Omar Sandoval wrote:
[ .. ]
>>>
>>> I actually checked losetup, it works just fine with LO_FLAGS_BLOCKSIZE
>>> always set and lo_init[0] always filled in.
>>>
>> The original argument I had with the util-linux maintainer did not
>> revolve so much around technical details :-)
> 
> Karel, what were your concerns here?
> 
It wasn't Karel, it was our guy.
Doesn't make it any better, though...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
