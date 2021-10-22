Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30B0C433F5
	for <linux-block@archiver.kernel.org>; Fri, 22 Oct 2021 03:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D279A61882
	for <linux-block@archiver.kernel.org>; Fri, 22 Oct 2021 03:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbhJVDP2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Oct 2021 23:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbhJVDP2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Oct 2021 23:15:28 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C459C061764
        for <linux-block@vger.kernel.org>; Thu, 21 Oct 2021 20:13:11 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id y12so519014eda.4
        for <linux-block@vger.kernel.org>; Thu, 21 Oct 2021 20:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mariadb.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=NWPB4CAXhxVJwiGIVfHAuBvSiaK2u2qvRHeXXrzdNYc=;
        b=SttAMN+Cjw38JQJlp6ZpUWvnKq5odokJfF+XhWq52MQcAjczUgcNhbJ7M4MtvIdzks
         fvCtsshEFw2pC+owTs7JRjV/ZxXG7AUjSTPK9GMLEACcXsEKwaAMNkH0RNgbgxXUzcMw
         G35LTZa4FmCrFJAnSIdDEvJRb9zBUfPvRd4xPbMHicuMrQXIu3+VK4QfUkb1k1xbwh4M
         ABlZJsRWogW/kSCluhh4SlbWe64Zovr6N+32amG1Hihav9pTQ++uwvVwO2gchuevOsIo
         9lFXdumKataUvuYYxO1ec4whfyaFGI/iM2hgPNNfolku3FG9YtHpVZhuDrZzFklh9mXB
         naUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=NWPB4CAXhxVJwiGIVfHAuBvSiaK2u2qvRHeXXrzdNYc=;
        b=THothE6gjrVZNATiGjd4muS5VFQkFYkVw0dHah1ch1bpC2R3pYpeJsawrszY2gd01g
         7vynefNHhjQ5T5VMMgtnwBoUy1QHzoB+RRg+nlyWPVBYWLrD/ux80dlfYpfwK8aNkN9Y
         CwDZ2qzSxPxU0fdt6b9RvYLy9wRv0zDQnMxpZlE+YhBFc0Jq4yFfAm9sEtFeUwDbsPv0
         SnODs2I5gZvnjeaoZgYS69FVhRmLuY3ID2namkyzaPJneZ+B4gGBYL/5LF6T4XzZiRIH
         OunzLza8LL7Of8ObBkWqrd9gbmVlEVWxVL+DJ2J1X64u0CEbg7AGeHDZuamXT8fEwUQT
         WZKA==
X-Gm-Message-State: AOAM532lMbh7ezpBm2rSQe9Gvpt0U1NWt5h+RlBaP+KhmMkzhfKMKg30
        yNsH9cZjiC9BkoDqygcYlY9ZK42yA9NzGjmmWf03WboONeyjQA==
X-Google-Smtp-Source: ABdhPJyMltF15+W7n89Z0hAXtK2/y2/b8oPAftKKPvPqrI8Tp0kpPCzZ2Mt0hnNnm8qmbPWK12jE1WCFO/gpb37pjDg=
X-Received: by 2002:a17:907:7691:: with SMTP id jv17mr11468886ejc.378.1634872389480;
 Thu, 21 Oct 2021 20:13:09 -0700 (PDT)
MIME-Version: 1.0
From:   Daniel Black <daniel@mariadb.org>
Date:   Fri, 22 Oct 2021 14:12:58 +1100
Message-ID: <CABVffENnJ8JkP7EtuUTqi+VkJDBFU37w1UXe4Q3cB7-ixxh0VA@mail.gmail.com>
Subject: uring regression - lost write request
To:     linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Sometime after 5.11 and is fixed in 5.15-rcX (rc6 extensively tested
over last few days) is a kernel regression we are tracing in
https://jira.mariadb.org/browse/MDEV-26674 and
https://jira.mariadb.org/browse/MDEV-26555
5.10 and early across many distros and hardware appear not to have a problem.

I'd appreciate some help identifying a 5.14 linux stable patch
suitable as I observe the fault in mainline 5.14.14 (built
https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.14.14/). This is of
interest to both Debian (sid)
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=996951 , Ubuntu
(Impish) and Fedora fc33-35 (TODO bug report)..

Marko in https://jira.mariadb.org/browse/MDEV-26555?focusedCommentId=198601&page=com.atlassian.jira.plugin.system.issuetabpanels:comment-tabpanel#comment-198601
traced this down to a io_uring_wait_cqe never returning after a
request was pushed.

The observed behavior uses a mariadb-test package for 10.6

dan@impish:~$ uname -a
Linux impish 5.14.14-051414-generic #202110201037 SMP Wed Oct 20
11:04:11 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux

dan@impish:~$ cd /usr/share/mysql/mysql-test/

dan@impish:/usr/share/mysql/mysql-test$ ./mtr --vardir=/tmp/var
--parallel=4 stress.ddl_innodb stress.ddl_innodb stress.ddl_innodb
stress.ddl_innodb    stress.ddl_innodb stress.ddl_innodb
stress.ddl_innodb stress.ddl_innodb  stress.ddl_innodb
stress.ddl_innodb stress.ddl_innodb stress.ddl_innodb
stress.ddl_innodb stress.ddl_innodb stress.ddl_innodb
stress.ddl_innodb
Logging: ./mtr  --vardir=/tmp/var --parallel=4 stress.ddl_innodb
stress.ddl_innodb stress.ddl_innodb stress.ddl_innodb
stress.ddl_innodb stress.ddl_innodb stress.ddl_innodb
stress.ddl_innodb stress.ddl_innodb stress.ddl_innodb
stress.ddl_innodb stress.ddl_innodb stress.ddl_innodb
stress.ddl_innodb stress.ddl_innodb stress.ddl_innodb
vardir: /tmp/var
Removing old var directory...
Creating var directory '/tmp/var'...
Checking supported features...
MariaDB Version 10.6.5-MariaDB-1:10.6.5+maria~impish
 - SSL connections supported
 - binaries built with wsrep patch
Collecting tests...
Installing system database...

==============================================================================

TEST                                  WORKER RESULT   TIME (ms) or COMMENT
--------------------------------------------------------------------------

worker[1] Using MTR_BUILD_THREAD 300, with reserved ports 16000..16019
worker[4] Using MTR_BUILD_THREAD 301, with reserved ports 16020..16039
worker[3] Using MTR_BUILD_THREAD 302, with reserved ports 16040..16059
worker[2] Using MTR_BUILD_THREAD 303, with reserved ports 16060..16079
stress.ddl_innodb 'innodb'               w3 [ pass ]  185605
stress.ddl_innodb 'innodb'               w4 [ pass ]  186292
stress.ddl_innodb 'innodb'               w2 [ pass ]  193053
stress.ddl_innodb 'innodb'               w1 [ pass ]  202529
stress.ddl_innodb 'innodb'               w4 [ pass ]  213972
stress.ddl_innodb 'innodb'               w3 [ pass ]  214661
stress.ddl_innodb 'innodb'               w1 [ pass ]  213266
stress.ddl_innodb 'innodb'               w4 [ pass ]  181716
stress.ddl_innodb 'innodb'               w3 [ pass ]  194047
stress.ddl_innodb 'innodb'               w1 [ pass ]  208319
stress.ddl_innodb 'innodb'               w2 [ fail ]
        Test ended at 2021-10-22 01:24:22

----------SERVER LOG START-----------
2021-10-22  1:24:20 0 [ERROR] [FATAL] InnoDB:
innodb_fatal_semaphore_wait_threshold was exceeded for dict_sys.latch.
Please refer to
https://mariadb.com/kb/en/how-to-produce-a-full-stack-trace-for-mysqld/

This threshold is 10 minutes so its not like the hardware is that slow.

To my frustration, the hirsuite based container (below) created as a
test framework for you has never produced a fault even though running
on the same 5.14.14-200.fc34.x86_64 kernel that would fail after 2-3
stress.ddl_innodb tests.

$ podman run   --rm --privileged=true
quay.io/danielgblack/mariadb-test:uring    --vardir=/var/tmp
stress.ddl_innodb{,,,,,,,,,,,,,}
...
--------------------------------------------------------------------------
The servers were restarted 0 times
Spent 2908.065 of 822 seconds executing testcases

Completed: All 18 tests were successful.

Looking at server test logs in /var/tmp/[0-9]/*/*err* the mariadbd
process are using uring.

I hope provides a hint.

In the mean time, the complete reproduce is to pull a 10.6 disto
package from https://mariadb.org/download/?tab=repo-config
It has to be a distro that provides liburing like:
Debian sid
Ubuntu - groovy+
Rhel8
Fedora

(centos/rhel are doing the incorrect baseurl currently, replace the
last fragement of the path, with [rhel|centos][7|8]-$arch )
Install repo.
Install Package mariadb-test (pull in MariaDB server as dependency).
ldd /usr/{s}bin/mariadbd to check liburing is there.

cd /usr/share/mysql/mysql-test
./mtr --vardir=/tmp/var   --parallel=4 encryption.innochecksum{,,,,,}
./mtr --vardir=/tmp/var   --parallel=4 stress.ddl_innodb{,,,,,}

Should generate a backtrace like above.

As an mtr argument with gdb and xterm installed the following will
breakpoint the application at this state.
 --gdb='b ib::fatal::~fatal;r'

I'm happy to build from a tree like
https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/log/?h=io_uring-5.15
if you'd like to to test something locally.

I can also run bpftrace scripts to pull out info if required.
