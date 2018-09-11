Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:36156 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbeIKGpL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Sep 2018 02:45:11 -0400
Subject: Re: [PATCH] percpu-refcount: relax limit on percpu_ref_reinit()
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org
References: <20180909125824.9150-1-ming.lei@redhat.com>
 <d4fb5fcc-305e-b3a7-0124-9c7b75042f01@oracle.com>
 <20180910161135.GA27430@ming.t460p>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <e91ee38e-3ea2-a003-2aac-8a8cc5c8f04a@oracle.com>
Date: Tue, 11 Sep 2018 09:48:15 +0800
MIME-Version: 1.0
In-Reply-To: <20180910161135.GA27430@ming.t460p>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Ming

On 09/11/2018 12:11 AM, Ming Lei wrote:
> Hi Jianchao,
> 
> On Mon, Sep 10, 2018 at 09:40:35AM +0800, jianchao.wang wrote:
>> Hi Ming
>>
>> On 09/09/2018 08:58 PM, Ming Lei wrote:
>>> Now percpu_ref_reinit() can only be done on one percpu refcounter
>>> when it drops zero. And the limit shouldn't be so strict, and it
>>> is quite straightforward that percpu_ref_reinit() can be done when
>>> this counter is at atomic mode.
>>
>> As we know, when the percpu_ref is switched to atomic mode, the values
>> of the per cpu will be sumed up to the atomic conter in percpu_ref_switch_to_atomic_rcu.
> 
> Right.
> 
>>
>> However, the tricky part is:
>> when we switch back to percpu mode, how can we know the exact value of the value of every cpu ?
> 
> The exact value of each CPU is zero at the exact time:
> 
> 1) when percpu mode is switched from atomic mode
> 
> percpu_ref_switch_to_atomic_rcu() is the point where no any percpu inc/dec
> can happen any more. And in this function the percpu count is sumed up to
> the atomic counter, meantime this patch clears the percpu value. It means
> once the refcount is switched to atomic mode, the percpu value is always
> zero, doesn't it?
> 
> 2) when the percpu-refcount is initialized at percpu mode
> 
> the percpu value is zero too.

What we want to get is to switch the percpu refcounter to percpu mode from atomic mode when
the refcounter has _not_ been drained to zero, instead of just to discard the warning, right ?

When we have sumed the values of every cpu's refcounter to a global atomic counter, how can
we give the values back to the refcounter of every cpu ?


Thanks
Jianchao

> 
>>
>> Draining the percpu refcounter to zero before switch it back to percpu mode should be relatively
>> easy to implement. And also, this is the initial intention of percpu refcounter, only switch
> 
> No, I don't think so, we can extend the percpu-refcount implementation to
> cover the NVMe timeout case easily. Then no necessary to reinvent a new wheel
> to address that issue.
> 
>> to atomic mode when want to drain the refcounter. 
> 
> 
> Thanks,
> Ming
> 
