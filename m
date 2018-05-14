Return-Path: <linux-block-owner@vger.kernel.org>
Received: from a9-54.smtp-out.amazonses.com ([54.240.9.54]:36582 "EHLO
        a9-54.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751865AbeENUPv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 May 2018 16:15:51 -0400
Date: Mon, 14 May 2018 20:15:50 +0000
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
In-Reply-To: <20180514185520.GA7398@cmpxchg.org>
Message-ID: <01000163604b7e9e-c2729157-aed2-4f5b-bebe-1bf16261ab88-000000@email.amazonses.com>
References: <20180507210135.1823-1-hannes@cmpxchg.org> <010001635f4e8be9-94e7be7a-e75c-438c-bffb-5b56301c4c55-000000@email.amazonses.com> <20180514185520.GA7398@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, 14 May 2018, Johannes Weiner wrote:

> Since I'm using the same model and infrastructure for memory and IO
> load as well, IMO it makes more sense to present them in a coherent
> interface instead of trying to retrofit and change the loadavg file,
> which might not even be possible.

Well I keep looking at the loadavg output from numerous tools and then in
my mind I divide by the number of processors, guess if any of the threads
would be doing I/O and if I cannot figure that out groan and run "vmstat"
for awhile to figure that out.

Lets have some numbers there that make more sense please.
