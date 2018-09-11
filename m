Return-Path: <linux-block-owner@vger.kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:51532 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbeIKJiP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Sep 2018 05:38:15 -0400
Subject: Re: [PATCH] percpu-refcount: relax limit on percpu_ref_reinit()
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org
References: <20180909125824.9150-1-ming.lei@redhat.com>
 <d4fb5fcc-305e-b3a7-0124-9c7b75042f01@oracle.com>
 <20180910161135.GA27430@ming.t460p>
 <e91ee38e-3ea2-a003-2aac-8a8cc5c8f04a@oracle.com>
 <20180911040323.GC30977@ming.t460p>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <771fa1eb-85d3-2ff2-6070-207874da85b6@oracle.com>
Date: Tue, 11 Sep 2018 12:40:36 +0800
MIME-Version: 1.0
In-Reply-To: <20180911040323.GC30977@ming.t460p>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Ming

On 09/11/2018 12:03 PM, Ming Lei wrote:
> After the refcount is switched to atomic mode, the whole counting is
> done on the atomic part. Then if the refcount need to switch to percpu mode
> again, all percpu part of the counter is re-initialized as zero simply. This
> is invariant with/without this patch.

Does the "whole counting" here means ?

(long)(sum (every cpu's refcounter)) + atomic refcounter

and when switch to atomic mode, there could be value left in atomic refcounter.
then the unsigned long percpu refcounter cound be decreased from 0.
	
>From another angle, one request could be ended on a different cpu from the one where
it is issued.

Thanks
Jianchao
