Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v3] block: make iolatency avg_lat exponentially decay
To: Dennis Zhou <dennisszhou@gmail.com>, Tejun Heo <tj@kernel.org>,
 Josef Bacik <jbacik@fb.com>, Johannes Weiner <hannes@cmpxchg.org>
Cc: kernel-team@fb.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20180802061541.49173-1-dennisszhou@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <24d21a5c-f061-63ca-4571-ed32f1c8e2d3@kernel.dk>
Date: Thu, 2 Aug 2018 09:58:32 -0600
MIME-Version: 1.0
In-Reply-To: <20180802061541.49173-1-dennisszhou@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/2/18 12:15 AM, Dennis Zhou wrote:
> From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
> 
> Currently, avg_lat is calculated by accumulating the mean of every
> window in a long running cumulative average. As time goes on, the metric
> becomes less and less useful due to the accumulated history.
> 
> This patch reuses the same calculation done in load averages to make the
> avg_lat metric more lively. Unlike load averages, the avg only advances
> when a window elapses (due to an io). Idle periods extend the most
> recent window. Bucketing is used to limit the history of avg_lat by
> binding it to the window size. So, the window range for 1/exp (decay
> rate) is [1 min, 2.5 min) when windows elapse immediately.
> 
> The current sample window size is exposed in the debug info to enable
> calculation of the window range.

Applied for 4.19, thanks Dennis.

-- 
Jens Axboe
