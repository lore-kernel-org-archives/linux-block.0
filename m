Return-Path: <linux-block-owner@vger.kernel.org>
Received: from out002.mailprotect.be ([83.217.72.86]:37755 "EHLO
        out002.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbeIIXhY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 Sep 2018 19:37:24 -0400
Message-ID: <1536518780.23536.3.camel@acm.org>
Subject: Re: [PATCH] percpu-refcount: relax limit on percpu_ref_reinit()
From: Bart Van Assche <bvanassche@acm.org>
To: Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org
Date: Sun, 09 Sep 2018 11:46:20 -0700
In-Reply-To: <20180909125824.9150-1-ming.lei@redhat.com>
References: <20180909125824.9150-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sun, 2018-09-09 at 20:58 +-0800, Ming Lei wrote:
+AD4 Now percpu+AF8-ref+AF8-reinit() can only be done on one percpu refcounter
+AD4 when it drops zero. And the limit shouldn't be so strict, and it
+AD4 is quite straightforward that percpu+AF8-ref+AF8-reinit() can be done when
+AD4 this counter is at atomic mode.
+AD4 
+AD4 This patch relaxes the limit, so we may avoid extra change+AFs-1+AF0 for NVMe
+AD4 timeout's requirement.
+AD4 
+AD4 +AFs-1+AF0 https://marc.info/?l+AD0-linux-kernel+ACY-m+AD0-153612052611020+ACY-w+AD0-2

Is the NVMe driver the only block driver that hangs if it is attempted to
freeze its request queue when a request times out? If so, can this hang be
fixed by modifying the NVMe driver instead of by modifying the percpu
refcount implementation?

Thanks,

Bart.
