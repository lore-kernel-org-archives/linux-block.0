Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH BUGFIX/IMPROVEMENT 0/4] block, bfq: series of fixes of
 bugs affecting service guarantees
To: Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org, broonie@kernel.org, lee.tibbert@gmail.com,
 oleksandr@natalenko.name, mirkomontanari91@gmail.com,
 angeloruocco90@gmail.com, mauro.andreolini@unimore.it
References: <20170921090403.3217-1-paolo.valente@linaro.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <f5649ee2-a807-6a9e-fb16-d9e14c40ab6f@kernel.dk>
Date: Tue, 3 Oct 2017 08:41:10 -0600
MIME-Version: 1.0
In-Reply-To: <20170921090403.3217-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 09/21/2017 03:03 AM, Paolo Valente wrote:
> Hi,
> the first patch in this series fixes a bug that causes bfq to fail to
> guarantee a high responsiveness on some drives, if there is heavy
> random read+write I/O in the background. More precisely, such a
> failure allowed this bug to be found [1], but the bug may well cause
> other yet unreported anomalies.
> 
> This fix uncovered other bugs that were concealed by the fixed bug,
> for rather subtle reasons. These further bugs caused similar
> responsiveness failures, but with sequential reaad+write workloads in
> the background. The remaining three patches fix these further bugs.
> 
> The sum of these fixes makes responsiveness much stabler with BFQ. In
> the presence of write hogs, it is however still impossible for an I/O
> scheduler to guarantee perfect responsiveness in any circustance,
> because of throttling issues in the virtual-memory management
> subsystem, and in other higher-level components.

Added for 4.15, thanks.

-- 
Jens Axboe
