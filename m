Return-Path: <SRS0=yN0i=YX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4111FCA9EC7
	for <linux-block@archiver.kernel.org>; Wed, 30 Oct 2019 22:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A70520873
	for <linux-block@archiver.kernel.org>; Wed, 30 Oct 2019 22:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfJ3W2h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Oct 2019 18:28:37 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39724 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfJ3W2h (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Oct 2019 18:28:37 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 6391C28F108
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-block@vger.kernel.org
Cc:     osandov@fb.com, kernel@collabora.com, krisman@collabora.com,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH blktests v2 0/3] Add --config argument for custom config filenames
Date:   Wed, 30 Oct 2019 19:27:04 -0300
Message-Id: <20191030222707.10142-1-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Instead of just using the default config file, one may also find useful to
specify which configuration file would like to use without editing the config
file, like this:

$ ./check --config=tests_nvme
...
$ ./check -c tests_scsi

This pull request solves this. This change means to be optional, in the sense
that the default behavior should not be modified and current setups will not be
affect by this. To check if this is true, I have done the following test:

- Print the value of variables $DEVICE_ONLY, $QUICK_RUN, $TIMEOUT,
  $RUN_ZONED_TESTS, $OUTPUT, $EXCLUDE
  
- Run with the following setups:
    - with a config file in the dir
    - without a config file in the dir
    - configuring using command line arguments

With both original code and with my changes, I validated that the values
remained the same. Then, I used the argument --config=test_config to check that
the values of variables are indeed changing.

This patchset add this feature, update the docs and fix a minor issue with a
command line argument. Also, I have changed "# shellcheck disable=SC1091" to
"# shellcheck source=/dev/null", since it seems the proper way to disable this
check according to shellcheck documentation[1].

Thanks,
André

Changes since v1:
- Reorder commit, so bug fix comes first
- Document multiple -c options behavior


[1] https://github.com/koalaman/shellcheck/wiki/SC1090#exceptions

This patch is also avaible at GitHub:
https://github.com/osandov/blktests/pull/56

André Almeida (3):
  check: Make "device-only" option a valid option
  check: Add configuration file option
  Documentation: Add information about `--config` argument

 Documentation/running-tests.md |  4 +++-
 check                          | 30 +++++++++++++++++++++++++-----
 2 files changed, 28 insertions(+), 6 deletions(-)

-- 
2.23.0

