Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-by2nam01on0041.outbound.protection.outlook.com ([104.47.34.41]:31664
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751520AbdBBWif (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 2 Feb 2017 17:38:35 -0500
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "snitzer@redhat.com" <snitzer@redhat.com>
CC: "hch@lst.de" <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
Subject: Re: split scsi passthrough fields out of struct request V2
Date: Thu, 2 Feb 2017 22:38:26 +0000
Message-ID: <1486075093.2816.20.camel@sandisk.com>
References: <1485910862.3113.12.camel@sandisk.com>
         <9198f024-9d55-3a28-9f77-ecbca42873b5@kernel.dk>
         <1485967586.2560.1.camel@sandisk.com>
         <7e963480-edf9-5687-25f3-83890373a26f@kernel.dk>
         <1485986472.2560.14.camel@sandisk.com>
         <1486056424.2816.4.camel@sandisk.com> <20170202183334.GB26910@redhat.com>
         <1486060991.2816.8.camel@sandisk.com> <20170202191330.GA27107@redhat.com>
         <1486064795.2816.14.camel@sandisk.com> <20170202210434.GA27548@redhat.com>
In-Reply-To: <20170202210434.GA27548@redhat.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, 2017-02-02 at 16:04 -0500, Mike Snitzer wrote:
> Any progress on getting this to work without requiring infiniband HW?

Hello Mike,

Intructions for running these tests over SoftRoCE have been added to
the README.md file in https://github.com/bvanassche/srp-test. However,
I'm not sure the SoftRoCE driver is already stable enough to run these
tests on top of that driver.

Bart.=
