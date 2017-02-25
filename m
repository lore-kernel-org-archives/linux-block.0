Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
From: Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Subject: [WIP BRANCH] cgroups support in bfq-mq WIP branch
Message-Id: <CBE2870C-EEB4-4C2E-A5A3-20C37E16B6AE@linaro.org>
Date: Sat, 25 Feb 2017 18:44:26 +0100
To: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "tj@kernel.org" <tj@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>,
 Bart Van Assche <bart.vanassche@sandisk.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
List-ID: <linux-block@vger.kernel.org>

Hi,
I've just completed cgroups support, and I'd like to highlight the
main blk-mq issue that I have found along the way.  I have pushed the
commit that completes the support for cgroups to the usual WIP branch
[1].  Before moving to this issue, I have preliminary question about
the scheduler name, since I'm about to start preparing the patch
series for submission.  So far, I have used bfq-mq as a temporary
name.  Are we fine with it, or should I change it, for example, to
just bfq?  Jens?

I've found a sort of circular dependency in blk-mq, related to
scheduler initialization.  To describe both the issue and how I've
addressed it, I'm pasting the message of the new commit.

    This commit completes cgroups support for bfq-mq. In particular, it =
deals with
    a sort of circular dependency introduced in blk-mq: the function
    blkcg_activate_policy, invoked during scheduler initialization, =
triggers the
    invocation of the has_work scheduler hook (before the init function =
is
    finished). To adress this issue, this commit moves the invocation of
    blkcg_activate_policy after the initialization of all the fields =
that could be
    initialized before invoking blkcg_activate_policy itself. This =
enables has_work
    to correctly return false, and thus to prevent the blk-mq stack from =
invoking
    further scheduler hooks before the init function is finished.

Thanks,
Paolo

[1] https://github.com/Algodev-github/bfq-mq=
