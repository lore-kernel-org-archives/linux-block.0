Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:56252 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbeIJKRF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Sep 2018 06:17:05 -0400
Subject: Re: [PATCH] percpu-refcount: relax limit on percpu_ref_reinit()
To: Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org
References: <20180909125824.9150-1-ming.lei@redhat.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <d4fb5fcc-305e-b3a7-0124-9c7b75042f01@oracle.com>
Date: Mon, 10 Sep 2018 09:40:35 +0800
MIME-Version: 1.0
In-Reply-To: <20180909125824.9150-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Ming

On 09/09/2018 08:58 PM, Ming Lei wrote:
> Now percpu_ref_reinit() can only be done on one percpu refcounter
> when it drops zero. And the limit shouldn't be so strict, and it
> is quite straightforward that percpu_ref_reinit() can be done when
> this counter is at atomic mode.

As we know, when the percpu_ref is switched to atomic mode, the values
of the per cpu will be sumed up to the atomic conter in percpu_ref_switch_to_atomic_rcu.

However, the tricky part is:
when we switch back to percpu mode, how can we know the exact value of the value of every cpu ?

Draining the percpu refcounter to zero before switch it back to percpu mode should be relatively
easy to implement. And also, this is the initial intention of percpu refcounter, only switch
to atomic mode when want to drain the refcounter. 


Thanks
Jianchao
