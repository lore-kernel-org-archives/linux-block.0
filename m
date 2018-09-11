Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-yw1-f65.google.com ([209.85.161.65]:36869 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbeIKVjG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Sep 2018 17:39:06 -0400
Date: Tue, 11 Sep 2018 09:38:56 -0700
From: Tejun Heo <tj@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-kernel@vger.kernel.org,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] percpu-refcount: relax limit on percpu_ref_reinit()
Message-ID: <20180911163856.GB2966370@devbig004.ftw2.facebook.com>
References: <20180909125824.9150-1-ming.lei@redhat.com>
 <20180910164920.GE1100574@devbig004.ftw2.facebook.com>
 <20180911000049.GB30977@ming.t460p>
 <20180911134836.GG1100574@devbig004.ftw2.facebook.com>
 <20180911154540.GA10082@ming.t460p>
 <20180911154959.GI1100574@devbig004.ftw2.facebook.com>
 <20180911160532.GB10082@ming.t460p>
 <20180911163032.GA2966370@devbig004.ftw2.facebook.com>
 <20180911163443.GD10082@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180911163443.GD10082@ming.t460p>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello, Ming.

On Wed, Sep 12, 2018 at 12:34:44AM +0800, Ming Lei wrote:
> > Why aren't switch_to_atomic/percpu enough?
> 
> The blk-mq's use case is this _reinit is done on one refcount which was
> killed via percpu_ref_kill(), so the DEAD flag has to be cleared.

If you killed and waited until kill finished, you should be able to
re-init.  Is it that you want to kill but abort killing in some cases?
How do you then handle the race against release?  Can you please
describe the exact usage you have on mind?

Thanks.

-- 
tejun
