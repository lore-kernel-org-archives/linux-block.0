Return-Path: <mingo.kernel.org@gmail.com>
Return-Path: <mingo.kernel.org@gmail.com>
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 24 Oct 2017 12:06:37 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Byungchul Park <byungchul.park@lge.com>
Cc: peterz@infradead.org, axboe@kernel.dk, tglx@linutronix.de,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, tj@kernel.org,
	johannes.berg@intel.com, oleg@redhat.com, amir73il@gmail.com,
	david@fromorbit.com, darrick.wong@oracle.com,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, hch@infradead.org, idryomov@gmail.com,
	kernel-team@lge.com
Subject: Re: [PATCH v3 3/8] lockdep: Remove BROKEN flag of
 LOCKDEP_CROSSRELEASE
Message-ID: <20171024100637.nryez5rgmykod54v@gmail.com>
References: <1508837889-16932-1-git-send-email-byungchul.park@lge.com>
 <1508837889-16932-4-git-send-email-byungchul.park@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1508837889-16932-4-git-send-email-byungchul.park@lge.com>
List-ID: <linux-block@vger.kernel.org>


better changelog:

================>
Subject: locking/lockdep: Remove the BROKEN flag from CONFIG_LOCKDEP_CROSSRELEASE and CONFIG_LOCKDEP_COMPLETIONS
From: Byungchul Park <byungchul.park@lge.com>
Date: Tue, 24 Oct 2017 18:38:04 +0900

Now that the performance regression is fixed, re-enable
CONFIG_LOCKDEP_CROSSRELEASE=y and CONFIG_LOCKDEP_COMPLETIONS=y.
