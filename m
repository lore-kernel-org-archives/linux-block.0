Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34825 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753227AbcEYHzH (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Wed, 25 May 2016 03:55:07 -0400
From: mchristi@redhat.com
To: linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	target-devel@vger.kernel.org
Subject: [PATCH 0/5] block/target queue/LUN reset support
Date: Wed, 25 May 2016 02:54:58 -0500
Message-Id: <1464162903-14735-1-git-send-email-mchristi@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Currently, for SCSI LUN_RESETs the target layer can only wait on
bio/requests it has sent. This normally results in the LUN_RESET
timing out on the initiator side and that SCSI error handler
escalating to something more disruptive.

To fix this, the following patches add a block layer helper and
callout to reset a request queue which the target layer can use
to force drivers to complete/fail executing requests.

Patches were made over Jens's block tree's for-next branch.

