Return-Path: <linux-block-owner@vger.kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:48962 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbeIKTWA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Sep 2018 15:22:00 -0400
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
 <771fa1eb-85d3-2ff2-6070-207874da85b6@oracle.com>
 <20180911082023.GA5360@ming.t460p>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <096be5c0-a69f-4553-5507-5fcdecc1ea20@oracle.com>
Date: Tue, 11 Sep 2018 22:22:22 +0800
MIME-Version: 1.0
In-Reply-To: <20180911082023.GA5360@ming.t460p>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Ming

On 09/11/2018 04:20 PM, Ming Lei wrote:
> We only check the 'whole counting' at atomic mode, so it is the atomic
> part('ref->count'), please see percpu_ref_put_many(), in which ref->release()
> is only called at atomic mode.
> 
> At percpu mode, the ref-count is only decreased/increased on the local CPU.

Yes, I got it.
Thanks for your kindly response.

Sincerely
Jianchao
