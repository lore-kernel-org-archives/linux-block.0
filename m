Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36000 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727475AbeIRNGP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Sep 2018 09:06:15 -0400
Date: Tue, 18 Sep 2018 15:34:43 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] percpu-refcount: relax limit on percpu_ref_reinit()
Message-ID: <20180918073442.GA4805@ming.t460p>
References: <20180909125824.9150-1-ming.lei@redhat.com>
 <3144ead9-0928-384d-0b04-fe8eb14fda52@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3144ead9-0928-384d-0b04-fe8eb14fda52@oracle.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Sep 18, 2018 at 11:21:25AM +0800, jianchao.wang wrote:
> Hi Ming
> 
> Will post the next version ?

Not see Tejun's further comment yet and suppose he is fine with the
approach, so will do that soon for further review.

Thanks,
Ming
