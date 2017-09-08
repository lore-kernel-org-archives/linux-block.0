Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH V2] block: sed-opal: Set MBRDone on S3 resume path if TPER
 is MBREnabled
To: Scott Bauer <scott.bauer@intel.com>
Cc: linux-block@vger.kernel.org, hch@infradead.org
References: <20170901145335.9244-1-scott.bauer@intel.com>
 <bcc3f33b-9ac1-59e5-09f3-41db81659a4a@intel.com>
 <20170908193610.b2nlhawecb2wiuy6@sbauer-Z170X-UD5>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <2ff49efd-ae62-8670-921a-046ccc9d35c6@kernel.dk>
Date: Fri, 8 Sep 2017 14:20:21 -0600
MIME-Version: 1.0
In-Reply-To: <20170908193610.b2nlhawecb2wiuy6@sbauer-Z170X-UD5>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 09/08/2017 01:36 PM, Scott Bauer wrote:
> On Tue, Sep 05, 2017 at 04:51:51PM -0600, Jon Derrick wrote:
> Jens, sorry to bother, can you take this? Or do you have any follow up comments?
> 
> RHEL Is starting to pull changes in for 7.5 I want to get this landed so they can
> pick it up.

I can pull it in for a pull request later in this merge window.

-- 
Jens Axboe
