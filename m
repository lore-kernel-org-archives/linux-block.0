Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33014 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752405AbeCOQqk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Mar 2018 12:46:40 -0400
Subject: Re: [PATCH 05/16] bcache: Remove an unused variable
To: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bart.vanassche@wdc.com>,
        Michael Lyle <mlyle@lyle.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org,
        linux-bcache <linux-bcache@vger.kernel.org>
References: <20180315150814.9412-1-bart.vanassche@wdc.com>
 <20180315150814.9412-6-bart.vanassche@wdc.com>
 <f91a53d3-f026-7e35-1c4e-f41afc52a565@suse.de>
 <20180315161352.GA21560@lst.de>
From: Coly Li <colyli@suse.de>
Message-ID: <ee2fdc81-f2c0-df77-c02c-40ce3841c8d7@suse.de>
Date: Fri, 16 Mar 2018 00:43:07 +0800
MIME-Version: 1.0
In-Reply-To: <20180315161352.GA21560@lst.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 16/03/2018 12:13 AM, Christoph Hellwig wrote:
> On Fri, Mar 16, 2018 at 12:11:16AM +0800, Coly Li wrote:
>> On 15/03/2018 11:08 PM, Bart Van Assche wrote:
>>> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
>>
>> Hi Bart,
>>
>> Could you please to add at least one line commit log ? Thanks in advance
>> for this :-)
> 
> Hi subject line perfectly describes the patch, so why?
> 
Hi Christoph,

We are trying to avoid patches with empty commit log for bcache patches.
A patch without commit log works, but just like the fixes to remove
smatch/sparse warning, adding commit log is preferred.

Thanks.

Coly Li
