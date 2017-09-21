Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
From: Paolo Valente <paolo.valente@linaro.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	broonie@kernel.org,
	lee.tibbert@gmail.com,
	oleksandr@natalenko.name,
	mirkomontanari91@gmail.com,
	angeloruocco90@gmail.com,
	mauro.andreolini@unimore.it,
	Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX/IMPROVEMENT 0/4] block, bfq: series of fixes of bugs affecting service guarantees
Date: Thu, 21 Sep 2017 11:03:59 +0200
Message-Id: <20170921090403.3217-1-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

Hi,
the first patch in this series fixes a bug that causes bfq to fail to
guarantee a high responsiveness on some drives, if there is heavy
random read+write I/O in the background. More precisely, such a
failure allowed this bug to be found [1], but the bug may well cause
other yet unreported anomalies.

This fix uncovered other bugs that were concealed by the fixed bug,
for rather subtle reasons. These further bugs caused similar
responsiveness failures, but with sequential reaad+write workloads in
the background. The remaining three patches fix these further bugs.

The sum of these fixes makes responsiveness much stabler with BFQ. In
the presence of write hogs, it is however still impossible for an I/O
scheduler to guarantee perfect responsiveness in any circustance,
because of throttling issues in the virtual-memory management
subsystem, and in other higher-level components.

Thanks,
Paolo

[1] Background I/O Type: Random - Background I/O mix: Reads and writes
- Application to start: LibreOffice Writer in
http://www.phoronix.com/scan.php?page=news_item&px=Linux-4.13-IO-Laptop


Paolo Valente (4):
  block, bfq: fix wrong init of saved start time for weight raising
  block, bfq: check and switch back to interactive wr also on queue
    split
  block, bfq: let early-merged queues be weight-raised on split too
  block, bfq: decrease burst size when queues in burst exit

 block/bfq-iosched.c | 169 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 102 insertions(+), 67 deletions(-)

--
2.10.0
