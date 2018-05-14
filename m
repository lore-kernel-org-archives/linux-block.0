Return-Path: <linux-block-owner@vger.kernel.org>
Received: from a9-46.smtp-out.amazonses.com ([54.240.9.46]:34400 "EHLO
        a9-46.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752416AbeENPje (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 May 2018 11:39:34 -0400
Date: Mon, 14 May 2018 15:39:33 +0000
From: Christopher Lameter <cl@linux.com>
To: Johannes Weiner <hannes@cmpxchg.org>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Mike Galbraith <efault@gmx.de>,
        Oliver Yang <yangoliver@me.com>,
        Shakeel Butt <shakeelb@google.com>,
        xxx xxx <x.qendo@gmail.com>,
        Taras Kondratiuk <takondra@cisco.com>,
        Daniel Walker <danielwa@cisco.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Ruslan Ruslichenko <rruslich@cisco.com>, kernel-team@fb.com
Subject: Re: [PATCH 0/7] psi: pressure stall information for CPU, memory,
 and IO
In-Reply-To: <20180507210135.1823-1-hannes@cmpxchg.org>
Message-ID: <010001635f4e8be9-94e7be7a-e75c-438c-bffb-5b56301c4c55-000000@email.amazonses.com>
References: <20180507210135.1823-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, 7 May 2018, Johannes Weiner wrote:

> What to make of this number? If CPU utilization is at 100% and CPU
> pressure is 0, it means the system is perfectly utilized, with one
> runnable thread per CPU and nobody waiting. At two or more runnable
> tasks per CPU, the system is 100% overcommitted and the pressure
> average will indicate as much. From a utilization perspective this is
> a great state of course: no CPU cycles are being wasted, even when 50%
> of the threads were to go idle (and most workloads do vary). From the
> perspective of the individual job it's not great, however, and they
> might do better with more resources. Depending on what your priority
> is, an elevated "some" number may or may not require action.

This looks awfully similar to loadavg. Problem is that loadavg gets
screwed up by tasks blocked waiting for I/O. Isnt there some way to fix
loadavg instead?
