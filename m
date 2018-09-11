Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:60404 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbeIKTNG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Sep 2018 15:13:06 -0400
Subject: Re: [PATCH] percpu-refcount: relax limit on percpu_ref_reinit()
To: Tejun Heo <tj@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org
References: <20180909125824.9150-1-ming.lei@redhat.com>
 <d4fb5fcc-305e-b3a7-0124-9c7b75042f01@oracle.com>
 <20180910161135.GA27430@ming.t460p>
 <e91ee38e-3ea2-a003-2aac-8a8cc5c8f04a@oracle.com>
 <20180911040323.GC30977@ming.t460p>
 <771fa1eb-85d3-2ff2-6070-207874da85b6@oracle.com>
 <20180911134404.GF1100574@devbig004.ftw2.facebook.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <e18c28d9-24dd-3048-a5e0-e3ed96643706@oracle.com>
Date: Tue, 11 Sep 2018 22:13:23 +0800
MIME-Version: 1.0
In-Reply-To: <20180911134404.GF1100574@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi tejun

On 09/11/2018 09:44 PM, Tejun Heo wrote:
> Hello,
> 
> On Tue, Sep 11, 2018 at 12:40:36PM +0800, jianchao.wang wrote:
>> (long)(sum (every cpu's refcounter)) + atomic refcounter
>>
>> and when switch to atomic mode, there could be value left in atomic refcounter.
>> then the unsigned long percpu refcounter cound be decreased from 0.
> 
> It can always do that.  Imagine a task getting a ref on one cpu,
> migrating and putting it on another.  The only thing which matters is
> that the sum of everything adds upto what it should be.
> 

Thanks for your kindly response.
I have got the point here.

Thanks
Jianchao
